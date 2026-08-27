import 'package:flutter/material.dart';

class RzComboBoxBasic<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) labelBuilder;
  final ValueChanged<int> onSelected;
  final int? initialIndex;
  final String hintText;
  final String labelText;
  final bool isRequired;
  final String noResultText;
  final String? errorText;

  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;
  final Color comboBoxBackgroundColor;
  final Color listBackgroundColor;
  final Color borderColor;
  final double borderRadius;

  final bool showClearIcon;
  final Widget? clearIcon;
  final bool showSuffixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final int visibleItemCount;
  final double itemHeight;

  const RzComboBoxBasic({
    super.key,
    required this.items,
    required this.labelBuilder,
    required this.onSelected,
    this.initialIndex,
    this.hintText = 'Select...',
    this.labelText = '',
    this.isRequired = false,
    this.noResultText = 'No result found',
    this.errorText,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.fontColor = Colors.black87,
    this.comboBoxBackgroundColor = Colors.white,
    this.listBackgroundColor = Colors.white,
    this.borderColor = const Color(0xFFE0E0E0),
    this.borderRadius = 6,
    this.showClearIcon = true,
    this.clearIcon,
    this.showSuffixIcon = true,
    this.suffixIcon,
    this.enabled = true,
    this.visibleItemCount = 5,
    this.itemHeight = 48,
  });

  @override
  State<RzComboBoxBasic<T>> createState() => _RzComboBoxBasicState<T>();
}

class _RzComboBoxBasicState<T> extends State<RzComboBoxBasic<T>> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final _layerLink = LayerLink();
  final _scrollController = ScrollController();

  OverlayEntry? _overlay;
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
    if (selectedIndex != null &&
        selectedIndex! >= 0 &&
        selectedIndex! < widget.items.length) {
      _controller.text = widget.labelBuilder(widget.items[selectedIndex!]);
    }
  }

  void _select(int index) {
    _hideOverlay();
    setState(() {
      selectedIndex = index;
      _controller.text = widget.labelBuilder(widget.items[index]);
    });
    widget.onSelected(index);
    _focusNode.unfocus();
  }

  void _clear() {
    setState(() {
      _controller.clear();
      selectedIndex = null;
    });
    _overlay?.markNeedsBuild();
  }

  void _showOverlay() {
    if (_overlay != null) {
      _overlay!.markNeedsBuild();
      return;
    }
    _overlay = _createOverlay();
    Overlay.of(context).insert(_overlay!);
  }

  void _hideOverlay() {
    _overlay?.remove();
    _overlay = null;
  }

  OverlayEntry _createOverlay() {
    final box = context.findRenderObject() as RenderBox;
    final size = box.size;
    final maxH = (widget.visibleItemCount * widget.itemHeight).toDouble();

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
              child: Material(
                color: widget.listBackgroundColor,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  side: BorderSide(color: widget.borderColor),
                ),
                clipBehavior: Clip.antiAlias,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: maxH),
                  child: widget.items.isEmpty
                      ? SizedBox(
                          height: widget.itemHeight,
                          child: Center(child: Text(widget.noResultText)),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: widget.items.length,
                          itemBuilder: (_, i) {
                            final isSel = i == selectedIndex;
                            return MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                color: isSel
                                    ? Colors.grey.withValues(alpha: 0.15)
                                    : null,
                                child: InkWell(
                                  onTap: () => _select(i),
                                  child: SizedBox(
                                    height: widget.itemHeight,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          widget.labelBuilder(widget.items[i]),
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
                              ),
                            );
                          },
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
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
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
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              enabled: widget.enabled,
              readOnly: true,
              mouseCursor: SystemMouseCursors.click,
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
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.showClearIcon && _controller.text.isNotEmpty)
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: IconButton(
                          icon:
                              widget.clearIcon ??
                              const Icon(Icons.clear, size: 20),
                          onPressed: _clear,
                        ),
                      ),
                    if (widget.showSuffixIcon)
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: IconButton(
                          icon:
                              widget.suffixIcon ??
                              const Icon(Icons.arrow_drop_down),
                          onPressed: () {
                            if (!widget.enabled) return;
                            if (_overlay == null) {
                              _showOverlay();
                            } else {
                              _hideOverlay();
                            }
                          },
                        ),
                      ),
                  ],
                ),
                errorText: widget.errorText,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(color: widget.borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(color: widget.borderColor, width: 1.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(color: widget.borderColor),
                ),
              ),
              onTap: () {
                if (!widget.enabled) return;
                if (_overlay == null) {
                  _showOverlay();
                } else {
                  _hideOverlay();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
