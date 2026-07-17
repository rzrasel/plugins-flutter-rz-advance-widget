import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RzIconTextFormFieldExtended extends StatefulWidget {
  const RzIconTextFormFieldExtended({
    super.key,
    this.controller,
    this.focusNode,
    this.initialValue,
    this.hintText,
    this.labelText,
    this.helperText,
    this.errorText,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixIconData,
    this.suffixIconData,
    this.prefixIconColor,
    this.suffixIconColor,
    this.prefixIconSize = 22,
    this.suffixIconSize = 22,
    this.onPrefixIconTap,
    this.onSuffixIconTap,
    // NEW
    this.showClearIcon = false,
    this.clearIcon,
    this.clearIconData,
    this.clearIconColor,
    this.clearIconSize = 22,
    this.onClearIconTap,
    this.style,
    this.hintStyle,
    this.labelStyle,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.expands = false,
    this.contentPadding,
    this.borderRadius,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.focusedErrorBorderColor,
    this.errorBorderWidth,
    this.focusedErrorBorderWidth,
    this.fillColor,
    this.filled = false,
    this.cursorColor,
    this.cursorHeight,
    this.cursorWidth = 2,
    this.inputFormatters,
    this.validator,
    this.onSaved,
    this.autoValidateMode,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onTapOutside,
    this.hideHintOnFocus = true,
    this.hideLabelOnFocusOut = true,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialValue;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final String? errorText;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final double prefixIconSize;
  final double suffixIconSize;
  final VoidCallback? onPrefixIconTap;
  final VoidCallback? onSuffixIconTap;

  final bool showClearIcon;
  final Widget? clearIcon;
  final IconData? clearIconData;
  final Color? clearIconColor;
  final double clearIconSize;
  final VoidCallback? onClearIconTap;

  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool expands;
  final EdgeInsetsGeometry? contentPadding;
  final dynamic borderRadius;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? focusedErrorBorderColor;
  final double? errorBorderWidth;
  final double? focusedErrorBorderWidth;
  final Color? fillColor;
  final bool filled;
  final Color? cursorColor;
  final double? cursorHeight;
  final double cursorWidth;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final AutovalidateMode? autoValidateMode;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final TapRegionCallback? onTapOutside;
  final bool hideHintOnFocus;
  final bool hideLabelOnFocusOut;

  @override
  State<RzIconTextFormFieldExtended> createState() =>
      _RzIconTextFormFieldExtendedState();
}

class _RzIconTextFormFieldExtendedState
    extends State<RzIconTextFormFieldExtended> {
  late FocusNode _effectiveFocusNode;
  bool _isInternalNode = false;
  late TextEditingController _effectiveController;
  bool _isInternalController = false;

  bool get _hasText => _effectiveController.text.isNotEmpty;

  bool get _hasFocus => _effectiveFocusNode.hasFocus;

  @override
  void initState() {
    super.initState();
    _initFocusNode();
    _initController();
  }

  void _initFocusNode() {
    _effectiveFocusNode = widget.focusNode ?? FocusNode();
    _isInternalNode = widget.focusNode == null;
    _effectiveFocusNode.addListener(_onFocusChange);
  }

  void _initController() {
    if (widget.controller != null) {
      _effectiveController = widget.controller!;
      _isInternalController = false;
    } else {
      _effectiveController = TextEditingController(text: widget.initialValue);
      _isInternalController = true;
    }
    _effectiveController.addListener(_onTextChange);
  }

  void _onFocusChange() => setState(() {});

  void _onTextChange() => setState(() {});

  @override
  void didUpdateWidget(covariant RzIconTextFormFieldExtended oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      oldWidget.focusNode?.removeListener(_onFocusChange);
      _effectiveFocusNode.removeListener(_onFocusChange);
      if (_isInternalNode) _effectiveFocusNode.dispose();
      _initFocusNode();
    }
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_onTextChange);
      _effectiveController.removeListener(_onTextChange);
      if (_isInternalController) _effectiveController.dispose();
      _initController();
    }
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_onFocusChange);
    _effectiveController.removeListener(_onTextChange);
    if (_isInternalNode) _effectiveFocusNode.dispose();
    if (_isInternalController) _effectiveController.dispose();
    super.dispose();
  }

  void _handleClear() {
    _effectiveController.clear();
    widget.onChanged?.call('');
    widget.onClearIconTap?.call();
  }

  Widget? _buildPrefixIcon() {
    if (widget.prefixIcon != null) return widget.prefixIcon;
    if (widget.prefixIconData == null) return null;
    if (widget.onPrefixIconTap != null) {
      return IconButton(
        onPressed: widget.onPrefixIconTap,
        icon: Icon(
          widget.prefixIconData,
          size: widget.prefixIconSize,
          color: widget.prefixIconColor,
        ),
      );
    }
    return Icon(
      widget.prefixIconData,
      size: widget.prefixIconSize,
      color: widget.prefixIconColor,
    );
  }

  Widget? _buildSuffixIcon() {
    final bool showClear = widget.showClearIcon && _hasText;

    if (!showClear) {
      if (widget.suffixIcon != null) return widget.suffixIcon;
      if (widget.suffixIconData == null) return null;
      if (widget.onSuffixIconTap != null) {
        return IconButton(
          onPressed: widget.onSuffixIconTap,
          icon: Icon(
            widget.suffixIconData,
            size: widget.suffixIconSize,
            color: widget.suffixIconColor,
          ),
        );
      }
      return Icon(
        widget.suffixIconData,
        size: widget.suffixIconSize,
        color: widget.suffixIconColor,
      );
    }

    // showClear = true
    Widget clearWidget;
    if (widget.clearIcon != null) {
      clearWidget = GestureDetector(
        onTap: _handleClear,
        child: widget.clearIcon!,
      );
    } else {
      clearWidget = IconButton(
        onPressed: _handleClear,
        icon: Icon(
          widget.clearIconData ?? Icons.clear,
          size: widget.clearIconSize,
          color: widget.clearIconColor,
        ),
        splashRadius: 20,
      );
    }

    // If also has suffix, show Row: clear + suffix
    if (widget.suffixIcon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [clearWidget, widget.suffixIcon!],
      );
    }
    if (widget.suffixIconData != null) {
      Widget suffixWidget;
      if (widget.onSuffixIconTap != null) {
        suffixWidget = IconButton(
          onPressed: widget.onSuffixIconTap,
          icon: Icon(
            widget.suffixIconData,
            size: widget.suffixIconSize,
            color: widget.suffixIconColor,
          ),
          splashRadius: 20,
        );
      } else {
        suffixWidget = Icon(
          widget.suffixIconData,
          size: widget.suffixIconSize,
          color: widget.suffixIconColor,
        );
      }
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [clearWidget, suffixWidget],
      );
    }

    return clearWidget;
  }

  BorderRadius _parseBorderRadius() {
    if (widget.borderRadius == null) return BorderRadius.circular(8);
    if (widget.borderRadius is BorderRadius) {
      return widget.borderRadius as BorderRadius;
    }
    if (widget.borderRadius is num) {
      return BorderRadius.circular((widget.borderRadius as num).toDouble());
    }
    return BorderRadius.zero;
  }

  @override
  Widget build(BuildContext context) {
    final radius = _parseBorderRadius();

    String? effectiveHint = widget.hintText;
    if (widget.hideHintOnFocus && _hasFocus) effectiveHint = null;
    if (effectiveHint != null && effectiveHint.trim().isEmpty) {
      effectiveHint = null;
    }

    final hasLabel =
        widget.labelText != null && widget.labelText!.trim().isNotEmpty;
    final showFloatingLabel = hasLabel
        ? (widget.hideLabelOnFocusOut ? _hasFocus : (_hasFocus || _hasText))
        : false;

    final theme = Theme.of(context);
    final bgColor = widget.filled
        ? (widget.fillColor ?? theme.inputDecorationTheme.fillColor)
        : theme.scaffoldBackgroundColor;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        TextFormField(
          controller: _effectiveController,
          focusNode: _effectiveFocusNode,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,
          textAlign: widget.textAlign,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          autofocus: widget.autofocus,
          obscureText: widget.obscureText,
          enableSuggestions: widget.enableSuggestions,
          autocorrect: widget.autocorrect,
          maxLines: widget.expands ? null : widget.maxLines,
          minLines: widget.expands ? null : widget.minLines,
          maxLength: widget.maxLength,
          expands: widget.expands,
          style: widget.style ?? const TextStyle(fontSize: 14),
          cursorColor: widget.cursorColor,
          cursorHeight: widget.cursorHeight,
          cursorWidth: widget.cursorWidth,
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          onSaved: widget.onSaved,
          autovalidateMode: widget.autoValidateMode,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.onFieldSubmitted,
          onTapOutside: widget.onTapOutside,
          decoration: InputDecoration(
            hintText: effectiveHint,
            helperText: widget.helperText,
            errorText: widget.errorText,
            hintStyle: widget.hintStyle,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: null,
            prefix: widget.prefix,
            suffix: widget.suffix,
            prefixIcon: _buildPrefixIcon(),
            suffixIcon: _buildSuffixIcon(),
            filled: widget.filled,
            fillColor: widget.fillColor,
            isDense: true,
            contentPadding:
                widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(color: widget.borderColor ?? Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(color: widget.borderColor ?? Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(
                color: widget.focusedBorderColor ?? theme.colorScheme.primary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(
                color: widget.errorBorderColor ?? Colors.red,
                width: widget.errorBorderWidth ?? 1.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(
                color: widget.focusedErrorBorderColor ?? Colors.red,
                width: widget.focusedErrorBorderWidth ?? 1.5,
              ),
            ),
          ),
        ),
        if (hasLabel)
          Positioned(
            left: 12,
            top: -8,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 180),
              opacity: showFloatingLabel ? 1 : 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                color: bgColor ?? Colors.white,
                child: Text(
                  widget.labelText!,
                  style:
                      widget.labelStyle ??
                      TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: _hasFocus
                            ? (widget.focusedBorderColor ??
                                  theme.colorScheme.primary)
                            : (widget.borderColor ?? Colors.grey.shade600),
                      ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}