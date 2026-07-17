import 'package:flutter/material.dart';

class RzCustomCheckbox extends StatelessWidget {
  const RzCustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,

    // Text
    this.text,
    this.textWidget,
    this.textStyle,

    // Position
    this.controlAffinity = ListTileControlAffinity.leading,

    // Colors
    this.activeColor,
    this.checkColor,
    this.fillColor,
    this.overlayColor,

    // Border
    this.shape,
    this.side,

    // State
    this.enabled = true,
    this.autofocus = false,
    this.tristate = false,
    this.isError = false,

    // Density
    this.dense,
    this.contentPadding,
    this.visualDensity,

    // Callback
    this.onTap,

    // --- NEW: Size & Customization ---
    this.checkboxSize = 22.0,
    this.tickSize = 16.0,
    this.borderColor,
    this.borderWidth = 1.8,
    this.borderRadius = 6.0,
    this.tickIcon,
    this.tickWidget,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
    this.enableRipple = true,
    this.rippleRadius = 24.0,
    this.unselectedFillColor,
    this.selectedFillColor,
  });

  //--------------------------------------------------------------------------
  // Value
  //--------------------------------------------------------------------------
  final bool? value;
  final ValueChanged<bool?>? onChanged;

  //--------------------------------------------------------------------------
  // Text
  //--------------------------------------------------------------------------
  final String? text;
  final Widget? textWidget;
  final TextStyle? textStyle;

  //--------------------------------------------------------------------------
  // Position
  //--------------------------------------------------------------------------
  final ListTileControlAffinity controlAffinity;

  //--------------------------------------------------------------------------
  // Colors
  //--------------------------------------------------------------------------
  final Color? activeColor;
  final Color? checkColor;
  final WidgetStateProperty<Color?>? fillColor;
  final WidgetStateProperty<Color?>? overlayColor;

  //--------------------------------------------------------------------------
  // Border
  //--------------------------------------------------------------------------
  final OutlinedBorder? shape;
  final BorderSide? side;

  //--------------------------------------------------------------------------
  // State
  //--------------------------------------------------------------------------
  final bool enabled;
  final bool autofocus;
  final bool tristate;
  final bool isError;

  //--------------------------------------------------------------------------
  // Density
  //--------------------------------------------------------------------------
  final bool? dense;
  final EdgeInsetsGeometry? contentPadding;
  final VisualDensity? visualDensity;

  //--------------------------------------------------------------------------
  // Callback
  //--------------------------------------------------------------------------
  final VoidCallback? onTap;

  //--------------------------------------------------------------------------
  // NEW Props
  //--------------------------------------------------------------------------
  final double checkboxSize;
  final double tickSize;
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final IconData? tickIcon;
  final Widget? tickWidget;
  final Duration animationDuration;
  final Curve animationCurve;
  final bool enableRipple;
  final double rippleRadius;
  final Color? unselectedFillColor;
  final Color? selectedFillColor;

  void _handleToggle() {
    if (!enabled) return;
    onTap?.call();
    if (onChanged == null) return;

    if (tristate) {
      if (value == null) {
        onChanged!(false);
      } else if (value == false) {
        onChanged!(true);
      } else {
        onChanged!(null);
      }
    } else {
      onChanged!(!(value ?? false));
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = textWidget ??
        (text != null
            ? Text(
          text!,
          style: textStyle,
        )
            : null);

    // Resolve colors
    final theme = Theme.of(context);
    final effectiveActiveColor = selectedFillColor ??
        activeColor ??
        fillColor?.resolve({WidgetState.selected}) ??
        theme.colorScheme.primary;
    final effectiveBorderColor = borderColor ??
        side?.color ??
        (isError ? theme.colorScheme.error : theme.colorScheme.outline);
    final effectiveCheckColor = checkColor ?? Colors.white;

    final checkboxWidget = _RzCustomCheckbox(
      value: value,
      enabled: enabled,
      size: checkboxSize,
      tickSize: tickSize,
      activeColor: effectiveActiveColor,
      checkColor: effectiveCheckColor,
      borderColor: effectiveBorderColor,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      tickIcon: tickIcon,
      tickWidget: tickWidget,
      unselectedFillColor: unselectedFillColor,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      isError: isError,
      tristate: tristate,
    );

    //--------------------------------------------------------------------------
    // Checkbox only
    //--------------------------------------------------------------------------
    if (title == null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? _handleToggle : null,
          borderRadius: BorderRadius.circular(borderRadius + 4),
          splashColor: enableRipple ? null : Colors.transparent,
          highlightColor: enableRipple ? null : Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: checkboxWidget,
          ),
        ),
      );
    }

    //--------------------------------------------------------------------------
    // Checkbox with label - Click anywhere toggles
    //--------------------------------------------------------------------------
    final contentPad = contentPadding ?? const EdgeInsets.symmetric(horizontal: 4);

    Widget tile = Padding(
      padding: contentPad as EdgeInsets? ?? EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (controlAffinity == ListTileControlAffinity.leading) ...[
            checkboxWidget,
            const SizedBox(width: 8),
            Flexible(child: title),
          ] else ...[
            Flexible(child: title),
            const SizedBox(width: 8),
            checkboxWidget,
          ],
        ],
      ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? _handleToggle : null,
        borderRadius: BorderRadius.circular(8),
        splashColor: enableRipple ? overlayColor?.resolve({WidgetState.pressed}) : Colors.transparent,
        highlightColor: enableRipple ? null : Colors.transparent,
        child: tile,
      ),
    );
  }
}

//==============================================================================
// INTERNAL: Fully Custom Checkbox with Animation
//==============================================================================
class _RzCustomCheckbox extends StatefulWidget {
  const _RzCustomCheckbox({
    required this.value,
    required this.enabled,
    required this.size,
    required this.tickSize,
    required this.activeColor,
    required this.checkColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.animationDuration,
    required this.animationCurve,
    this.tickIcon,
    this.tickWidget,
    this.unselectedFillColor,
    this.isError = false,
    this.tristate = false,
  });

  final bool? value;
  final bool enabled;
  final double size;
  final double tickSize;
  final Color activeColor;
  final Color checkColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final Duration animationDuration;
  final Curve animationCurve;
  final IconData? tickIcon;
  final Widget? tickWidget;
  final Color? unselectedFillColor;
  final bool isError;
  final bool tristate;

  @override
  State<_RzCustomCheckbox> createState() => _RzCustomCheckboxState();
}

class _RzCustomCheckboxState extends State<_RzCustomCheckbox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.animationCurve,
    );
    if (widget.value == true) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant _RzCustomCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == true) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    if (oldWidget.animationDuration != widget.animationDuration) {
      _controller.duration = widget.animationDuration;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isChecked = widget.value == true;
    final isIndeterminate = widget.value == null && widget.tristate;

    return AnimatedContainer(
      duration: widget.animationDuration,
      curve: widget.animationCurve,
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: isChecked || isIndeterminate
            ? widget.activeColor.withValues(alpha: widget.enabled ? 1.0 : 0.4,)
            : widget.unselectedFillColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: isChecked || isIndeterminate
              ? widget.activeColor.withValues(alpha: widget.enabled ? 1.0 : 0.4,)
              : widget.borderColor.withValues(alpha: widget.enabled ? 1.0 : 0.5,),
          width: widget.borderWidth,
        ),
      ),
      child: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: _buildTick(isChecked, isIndeterminate),
        ),
      ),
    );
  }

  Widget _buildTick(bool isChecked, bool isIndeterminate) {
    if (!isChecked && !isIndeterminate) {
      return const SizedBox.shrink();
    }

    if (widget.tickWidget != null) {
      return widget.tickWidget!;
    }

    if (isIndeterminate) {
      return Container(
        width: widget.size * 0.5,
        height: 2.5,
        decoration: BoxDecoration(
          color: widget.checkColor,
          borderRadius: BorderRadius.circular(2),
        ),
      );
    }

    // Custom Icon
    if (widget.tickIcon != null) {
      return Icon(
        widget.tickIcon,
        size: widget.tickSize,
        color: widget.checkColor,
      );
    }

    // Default tick icon with custom size
    return Icon(
      Icons.check_rounded,
      size: widget.tickSize,
      color: widget.checkColor,
      weight: 800,
    );
  }
}