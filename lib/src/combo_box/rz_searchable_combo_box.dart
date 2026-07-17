import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// RzSearchableComboBox - works on Android, iOS, Web, Windows, macOS, Linux
class RzSearchableComboBox<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) labelBuilder;
  final ValueChanged<int> onSelected;
  final ValueChanged<String>? onChanged;
  final Future<List<T>> Function(String query)? onSearch;
  final Widget Function(
    BuildContext context,
    T item,
    bool isSelected,
    bool isHighlighted,
  )?
  itemBuilder;
  final String? Function(String?)? validator;

  final int? initialIndex;
  final String hintText;
  final String labelText;
  final bool isRequired;
  final String noResultText;
  final String? errorText;

  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;
  final double noResultFontSize;
  final FontWeight noResultFontWeight;
  final Color noResultFontColor;
  final Color comboBoxBackgroundColor;
  final Color listBackgroundColor;
  final Color comboBoxBorderColor;
  final Color listBorderColor;
  final Color borderColor;
  final double borderRadius;

  final bool showDivider;
  final Color dividerColor;
  final double dividerHeight;
  final bool showPrefixIcon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool showClearIcon;
  final Widget? clearIcon;
  final bool showSuffixIcon;
  final bool enabled;
  final bool autoSort;
  final bool caseSensitive;
  final int debounceMs;
  final bool showScrollbar;
  final int visibleItemCount;
  final double itemHeight;

  const RzSearchableComboBox({
    super.key,
    required this.items,
    required this.labelBuilder,
    required this.onSelected,
    this.onChanged,
    this.onSearch,
    this.itemBuilder,
    this.validator,
    this.initialIndex,
    this.hintText = 'Search...',
    this.labelText = '',
    this.isRequired = false,
    this.noResultText = 'No result found',
    this.errorText,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.fontColor = Colors.black87,
    this.noResultFontSize = 14,
    this.noResultFontWeight = FontWeight.w400,
    this.noResultFontColor = Colors.grey,
    this.comboBoxBackgroundColor = Colors.white,
    this.listBackgroundColor = Colors.white,
    this.comboBoxBorderColor = const Color(0xFFE0E0E0),
    this.listBorderColor = const Color(0xFFE0E0E0),
    this.borderColor = const Color(0xFFE0E0E0),
    this.borderRadius = 6,
    this.showDivider = true,
    this.dividerColor = const Color(0xFFEEEEEE),
    this.dividerHeight = 1,
    this.showPrefixIcon = true,
    this.prefixIcon,
    this.suffixIcon,
    this.showClearIcon = true,
    this.clearIcon,
    this.showSuffixIcon = true,
    this.enabled = true,
    this.autoSort = false,
    this.caseSensitive = false,
    this.debounceMs = 300,
    this.showScrollbar = true,
    this.visibleItemCount = 5,
    this.itemHeight = 48,
  });

  @override
  State<RzSearchableComboBox<T>> createState() =>
      _RzSearchableComboBoxState<T>();
}

class _RzSearchableComboBoxState<T> extends State<RzSearchableComboBox<T>> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final _keyboardFocusNode = FocusNode();
  final _layerLink = LayerLink();
  final _scrollController = ScrollController();
  Timer? _debounce;

  List<MapEntry<int, T>> filtered = [];
  List<T> _allItems = [];
  OverlayEntry? _overlay;
  int? selectedIndex;
  int highlightedIndex = -1;
  bool isLoading = false;
  String? _validationError;

  Color get _comboBorder =>
      widget.comboBoxBorderColor != const Color(0xFFE0E0E0) ||
          widget.borderColor == const Color(0xFFE0E0E0)
      ? widget.comboBoxBorderColor
      : widget.borderColor;

  Color get _listBorder =>
      widget.listBorderColor != const Color(0xFFE0E0E0) ||
          widget.borderColor == const Color(0xFFE0E0E0)
      ? widget.listBorderColor
      : widget.borderColor;

  @override
  void initState() {
    super.initState();
    _keyboardFocusNode.canRequestFocus = true;
    _allItems = List.from(widget.items);
    filtered = _allItems.asMap().entries.toList();
    selectedIndex = widget.initialIndex;
    if (selectedIndex != null &&
        selectedIndex! >= 0 &&
        selectedIndex! < _allItems.length) {
      _controller.text = widget.labelBuilder(_allItems[selectedIndex!]);
    }
  }

  @override
  void didUpdateWidget(covariant RzSearchableComboBox<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _allItems = List.from(widget.items);
      filtered = _allItems.asMap().entries.toList();
      _overlay?.markNeedsBuild();
    }
  }

  void _filter(String q) {
    _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: widget.debounceMs), () async {
      widget.onChanged?.call(q);
      if (widget.validator != null) {
        setState(() => _validationError = widget.validator!(q));
      }

      if (widget.onSearch != null) {
        setState(() => isLoading = true);
        try {
          final result = await widget.onSearch!(q);
          _allItems = result;
        } finally {
          if (mounted) setState(() => isLoading = false);
        }
      }

      var list = q.isEmpty
          ? _allItems.asMap().entries.toList()
          : _allItems.asMap().entries.where((e) {
              final label = widget.labelBuilder(e.value);
              return widget.caseSensitive
                  ? label.contains(q)
                  : label.toLowerCase().contains(q.toLowerCase());
            }).toList();

      if (widget.autoSort) {
        list.sort(
          (a, b) => widget
              .labelBuilder(a.value)
              .compareTo(widget.labelBuilder(b.value)),
        );
      }

      if (mounted) {
        setState(() {
          filtered = list;
          highlightedIndex = filtered.isEmpty ? -1 : 0;
        });
      }
      _showOverlay();
    });
  }

  void _select(MapEntry<int, T> entry) {
    final text = widget.labelBuilder(entry.value);
    _hideOverlay();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        selectedIndex = entry.key;
        _controller.text = text;
        _controller.selection = TextSelection.collapsed(offset: text.length);
        filtered = _allItems.asMap().entries.toList();
        highlightedIndex = -1;
      });
      widget.onSelected(entry.key);
      widget.onChanged?.call(text);
      _focusNode.unfocus();
    });
  }

  void _clear() {
    setState(() {
      _controller.clear();
      selectedIndex = null;
      filtered = _allItems.asMap().entries.toList();
    });
    widget.onChanged?.call('');
    _overlay?.markNeedsBuild();
  }

  void _handleKey(KeyEvent event) {
    if (_overlay == null) return;
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        setState(
          () => highlightedIndex = (highlightedIndex + 1).clamp(
            0,
            filtered.length - 1,
          ),
        );
        _overlay?.markNeedsBuild();
      } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        setState(
          () => highlightedIndex = (highlightedIndex - 1).clamp(
            0,
            filtered.length - 1,
          ),
        );
        _overlay?.markNeedsBuild();
      } else if (event.logicalKey == LogicalKeyboardKey.enter &&
          highlightedIndex >= 0 &&
          highlightedIndex < filtered.length) {
        _select(filtered[highlightedIndex]);
      } else if (event.logicalKey == LogicalKeyboardKey.escape) {
        _hideOverlay();
      }
    }
  }

  void _showOverlay() {
    if (_overlay != null) {
      _overlay!.markNeedsBuild();
      return;
    }
    _overlay = _createOverlay();
    Overlay.of(context).insert(_overlay!);
    _keyboardFocusNode.requestFocus();
  }

  void _hideOverlay() {
    _overlay?.remove();
    _overlay = null;
    if (mounted) setState(() => highlightedIndex = -1);
  }

  OverlayEntry _createOverlay() {
    final box = context.findRenderObject() as RenderBox;
    final size = box.size;
    final maxH = widget.visibleItemCount == -1
        ? 300.0
        : (filtered.length.clamp(0, widget.visibleItemCount) *
                  widget.itemHeight)
              .toDouble();

    return OverlayEntry(
      builder: (_) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _hideOverlay,
            ),
          ),
          Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height + 4),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 150),
                builder: (_, v, child) => Opacity(
                  opacity: v,
                  child: Transform.scale(
                    scale: 0.95 + (0.05 * v),
                    alignment: Alignment.topCenter,
                    child: child,
                  ),
                ),
                child: Material(
                  color: widget.listBackgroundColor,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    side: BorderSide(color: _listBorder),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: maxH),
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: widget.showScrollbar,
                      child: isLoading
                          ? const SizedBox(
                              height: 48,
                              child: Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                            )
                          : filtered.isEmpty
                          ? SizedBox(
                              height: widget.itemHeight,
                              child: ListTile(
                                title: Text(
                                  widget.noResultText,
                                  style: TextStyle(
                                    fontSize: widget.noResultFontSize,
                                    fontWeight: widget.noResultFontWeight,
                                    color: widget.noResultFontColor,
                                  ),
                                ),
                              ),
                            )
                          : ListView.separated(
                              controller: _scrollController,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: filtered.length,
                              separatorBuilder: (_, __) => widget.showDivider
                                  ? Divider(
                                      height: widget.dividerHeight,
                                      color: widget.dividerColor,
                                      thickness: widget.dividerHeight,
                                    )
                                  : const SizedBox.shrink(),
                              itemBuilder: (_, i) {
                                final entry = filtered[i];
                                final isSel = entry.key == selectedIndex;
                                final isHigh = i == highlightedIndex;
                                if (widget.itemBuilder != null) {
                                  return InkWell(
                                    onTap: () => _select(entry),
                                    child: widget.itemBuilder!(
                                      context,
                                      entry.value,
                                      isSel,
                                      isHigh,
                                    ),
                                  );
                                }
                                return Container(
                                  color: isHigh
                                      ? Colors.blue.withValues(alpha: 0.08)
                                      : (isSel
                                            ? Colors.grey.withValues(
                                                alpha: 0.15,
                                              )
                                            : null),
                                  child: InkWell(
                                    onTap: () => _select(entry),
                                    child: SizedBox(
                                      height: widget.itemHeight,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            widget.labelBuilder(entry.value),
                                            style: TextStyle(
                                              fontSize: widget.fontSize,
                                              fontWeight: isSel
                                                  ? FontWeight.w600
                                                  : widget.fontWeight,
                                              color: widget.fontColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _hideOverlay();
    _controller.dispose();
    _focusNode.dispose();
    _keyboardFocusNode.dispose();
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _keyboardFocusNode,
      onKeyEvent: _handleKey,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.labelText.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: RichText(
                  text: TextSpan(
                    text: widget.labelText,
                    style: const TextStyle(color: Colors.black87, fontSize: 14),
                    children: [
                      if (widget.isRequired)
                        const TextSpan(
                          text: ' *',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
              ),
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              enabled: widget.enabled,
              style: TextStyle(
                fontSize: widget.fontSize,
                fontWeight: widget.fontWeight,
                color: widget.fontColor,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                filled: true,
                fillColor: widget.enabled
                    ? widget.comboBoxBackgroundColor
                    : Colors.grey.shade200,
                prefixIcon: widget.showPrefixIcon
                    ? (widget.prefixIcon ?? const Icon(Icons.search, size: 20))
                    : null,
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isLoading)
                      const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    if (widget.showClearIcon && _controller.text.isNotEmpty)
                      IconButton(
                        icon:
                            widget.clearIcon ??
                            const Icon(Icons.clear, size: 20),
                        onPressed: _clear,
                      ),
                    if (widget.showSuffixIcon)
                      IconButton(
                        icon:
                            widget.suffixIcon ??
                            const Icon(Icons.arrow_drop_down),
                        onPressed: () {
                          if (_overlay == null) {
                            filtered = _allItems.asMap().entries.toList();
                            _showOverlay();
                            _focusNode.requestFocus();
                          } else {
                            _hideOverlay();
                          }
                        },
                      ),
                  ],
                ),
                errorText: widget.errorText ?? _validationError,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(color: _comboBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(color: _comboBorder, width: 1.5),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(color: _comboBorder),
                ),
              ),
              onChanged: _filter,
              onTap: () {
                if (!widget.enabled) return;
                filtered = _allItems.asMap().entries.toList();
                _showOverlay();
              },
            ),
          ],
        ),
      ),
    );
  }
}