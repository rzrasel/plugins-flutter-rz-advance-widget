import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RzIconPasswordFormField extends StatefulWidget {
  const RzIconPasswordFormField({
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
    // NEW: Clear Icon
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
    this.obscureText = true,
    this.showVisibilityToggle = true,
    this.visibilityIcon = Icons.visibility_outlined,
    this.visibilityOffIcon = Icons.visibility_off_outlined,
    this.visibilityIconColor,
    this.enableSuggestions = false,
    this.autocorrect = false,
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
    this.hideHintOnFocus = false,
    this.floatHintToBorder = false,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
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

  // Clear Icon
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
  final bool showVisibilityToggle;
  final IconData visibilityIcon;
  final IconData visibilityOffIcon;
  final Color? visibilityIconColor;
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
  final bool floatHintToBorder;
  final FloatingLabelBehavior floatingLabelBehavior;

  @override
  State<RzIconPasswordFormField> createState() =>
      _RzIconPasswordFormFieldState();
}

class _RzIconPasswordFormFieldState extends State<RzIconPasswordFormField> {
  late FocusNode _effectiveFocusNode;
  bool _isInternalNode = false;
  late TextEditingController _effectiveController;
  bool _isInternalController = false;
  late bool _obscure;

  bool get _hasText => _effectiveController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
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

  void _onFocusChange() {
    if (widget.hideHintOnFocus || widget.floatHintToBorder) setState(() {});
  }

  void _onTextChange() => setState(() {});

  @override
  void didUpdateWidget(covariant RzIconPasswordFormField oldWidget) {
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
    if (oldWidget.obscureText != widget.obscureText) {
      _obscure = widget.obscureText;
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
    final bool hasVisibility = widget.showVisibilityToggle;
    final bool hasCustomData = widget.suffixIconData != null;
    final bool hasCustomWidget = widget.suffixIcon != null;

    // No icons at all
    if (!showClear && !hasVisibility && !hasCustomData && !hasCustomWidget) {
      return null;
    }

    List<Widget> icons = [];

    // 1. Clear Icon
    if (showClear) {
      if (widget.clearIcon != null) {
        icons.add(
          GestureDetector(onTap: _handleClear, child: widget.clearIcon!),
        );
      } else {
        icons.add(
          IconButton(
            onPressed: _handleClear,
            icon: Icon(
              widget.clearIconData ?? Icons.clear,
              size: widget.clearIconSize,
              color: widget.clearIconColor,
            ),
            splashRadius: 20,
          ),
        );
      }
    }

    // 2. Visibility Toggle
    if (hasVisibility) {
      icons.add(
        IconButton(
          onPressed: () => setState(() => _obscure = !_obscure),
          icon: Icon(
            _obscure ? widget.visibilityOffIcon : widget.visibilityIcon,
            size: widget.suffixIconSize,
            color: widget.visibilityIconColor ?? widget.suffixIconColor,
          ),
          splashRadius: 20,
        ),
      );
    } else if (hasCustomWidget) {
      icons.add(widget.suffixIcon!);
    } else if (hasCustomData) {
      if (widget.onSuffixIconTap != null) {
        icons.add(
          IconButton(
            onPressed: widget.onSuffixIconTap,
            icon: Icon(
              widget.suffixIconData,
              size: widget.suffixIconSize,
              color: widget.suffixIconColor,
            ),
            splashRadius: 20,
          ),
        );
      } else {
        icons.add(
          Icon(
            widget.suffixIconData,
            size: widget.suffixIconSize,
            color: widget.suffixIconColor,
          ),
        );
      }
    }

    if (icons.length == 1) return icons.first;
    return Row(mainAxisSize: MainAxisSize.min, children: icons);
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
    final hasFocus = _effectiveFocusNode.hasFocus;

    String? effectiveHint;
    String? effectiveLabel;

    if (widget.floatHintToBorder && hasFocus && widget.hintText != null) {
      effectiveLabel = widget.hintText;
      effectiveHint = null;
    } else if (widget.floatHintToBorder &&
        !hasFocus &&
        widget.hintText != null &&
        widget.labelText == null) {
      effectiveLabel = null;
      effectiveHint = widget.hintText;
    } else {
      effectiveLabel = widget.labelText;
      effectiveHint = (widget.hideHintOnFocus && hasFocus)
          ? null
          : widget.hintText;
    }

    if (widget.floatHintToBorder && widget.labelText != null) {
      effectiveLabel = widget.labelText;
      effectiveHint = hasFocus ? null : widget.hintText;
      if (widget.hideHintOnFocus && hasFocus) effectiveHint = null;
    }

    return TextFormField(
      controller: _effectiveController,
      focusNode: _effectiveFocusNode,
      // initialValue only when no controller - handled in _initController
      keyboardType: widget.keyboardType ?? TextInputType.visiblePassword,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      textAlign: widget.textAlign,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      obscureText: _obscure,
      enableSuggestions: widget.enableSuggestions,
      autocorrect: widget.autocorrect,
      maxLines: 1,
      minLines: widget.minLines,
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
        labelText: effectiveLabel,
        helperText: widget.helperText,
        errorText: widget.errorText,
        hintStyle: widget.hintStyle,
        labelStyle: widget.labelStyle,
        floatingLabelBehavior: widget.floatingLabelBehavior,
        prefix: widget.prefix,
        suffix: widget.suffix,
        prefixIcon: _buildPrefixIcon(),
        suffixIcon: _buildSuffixIcon(),
        filled: widget.filled,
        fillColor: widget.fillColor,
        isDense: true,
        contentPadding:
            widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            color:
                widget.focusedBorderColor ??
                Theme.of(context).colorScheme.primary,
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
    );
  }
}