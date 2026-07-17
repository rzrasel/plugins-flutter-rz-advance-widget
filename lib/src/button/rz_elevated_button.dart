import 'dart:async';
import 'package:flutter/material.dart';
import '/rz_advance_widget.dart';

class RzElevatedButton extends StatefulWidget {
  const RzElevatedButton({
    super.key,
    this.text,
    this.child,
    this.onPressed,
    this.icon,
    this.iconData,
    this.iconSize = 20,
    this.iconColor,
    this.iconPosition = RzButtonIconPosition.left,
    this.gap = 8,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.overlayColor,
    this.shadowColor,
    this.surfaceTintColor,
    this.loadingBackgroundColor,
    this.loadingForegroundColor,
    this.loadingIndicatorColor,
    this.borderRadius = 8,
    this.borderColor,
    this.loadingBorderColor,
    this.borderWidth = 1,
    this.elevation = 0,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    this.margin,
    this.minWidth,
    this.minHeight = 44,
    this.fullWidth = false,
    this.style,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
    this.isLoading = false,
    this.loadingWidget,
    this.enabled = true,
  });

  final String? text;
  final Widget? child;
  final FutureOr<void> Function()? onPressed;
  final Widget? icon;
  final IconData? iconData;
  final double iconSize;
  final Color? iconColor;
  final RzButtonIconPosition iconPosition;
  final double gap;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final Color? overlayColor;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final Color? loadingBackgroundColor;
  final Color? loadingForegroundColor;
  final Color? loadingIndicatorColor;
  final dynamic borderRadius;
  final Color? borderColor;
  final Color? loadingBorderColor;
  final double borderWidth;
  final double? elevation;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double? minWidth;
  final double minHeight;
  final bool fullWidth;
  final TextStyle? style;
  final double fontSize;
  final FontWeight fontWeight;
  final bool isLoading;
  final Widget? loadingWidget;
  final bool enabled;

  @override
  State<RzElevatedButton> createState() => _RzElevatedButtonState();
}

class _RzElevatedButtonState extends State<RzElevatedButton> {
  bool _internalLoading = false;

  BorderRadius _parseRadius() {
    if (widget.borderRadius is BorderRadius) return widget.borderRadius as BorderRadius;
    if (widget.borderRadius is num) return BorderRadius.circular((widget.borderRadius as num).toDouble());
    return BorderRadius.circular(8);
  }

  Future<void> _handlePress() async {
    if (widget.onPressed == null) return;
    if (_internalLoading || widget.isLoading) return;
    setState(() => _internalLoading = true);
    try {
      await widget.onPressed!.call();
    } catch (e) {
      debugPrint("RzElevatedButton error: $e");
    } finally {
      if (mounted) setState(() => _internalLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final radius = _parseRadius();
    final bool loading = widget.isLoading || _internalLoading;
    final bool disabled = !widget.enabled || loading;

    // ---- FIXED LOGIC HERE ----
    final Color normalBg = widget.backgroundColor ?? Theme.of(context).colorScheme.primary;
    final Color normalFg = widget.foregroundColor ?? Colors.white;

    final Color effectiveBg = loading ? (widget.loadingBackgroundColor ?? normalBg) : normalBg;
    final Color effectiveFg = loading ? (widget.loadingForegroundColor ?? normalFg) : normalFg;
    final Color? effectiveBorder = loading ? (widget.loadingBorderColor ?? widget.borderColor) : widget.borderColor;

    // When loading, we must override disabled colors too
    final Color effectiveDisabledBg = loading ? effectiveBg : (widget.disabledBackgroundColor ?? Colors.grey.shade300);
    final Color effectiveDisabledFg = loading ? effectiveFg : (widget.disabledForegroundColor ?? Colors.grey.shade600);

    final btnStyle = ElevatedButton.styleFrom(
      backgroundColor: effectiveBg,
      foregroundColor: effectiveFg,
      disabledBackgroundColor: effectiveDisabledBg, // <-- FIX
      disabledForegroundColor: effectiveDisabledFg, // <-- FIX
      shadowColor: widget.shadowColor,
      surfaceTintColor: widget.surfaceTintColor,
      elevation: widget.elevation,
      padding: widget.padding,
      minimumSize: Size(widget.minWidth ?? 0, widget.minHeight),
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: effectiveBorder != null ? BorderSide(color: effectiveBorder, width: widget.borderWidth) : BorderSide.none,
      ),
    );

    Widget content;
    if (loading) {
      content = widget.loadingWidget ??
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                widget.loadingIndicatorColor ?? effectiveFg,
              ),
            ),
          );
    } else if (widget.child != null) {
      content = widget.child!;
    } else {
      final textWidget = Text(
        widget.text ?? "",
        style: widget.style ?? TextStyle(fontSize: widget.fontSize, fontWeight: widget.fontWeight),
      );
      if (widget.icon != null || widget.iconData != null) {
        final iconWidget = widget.icon ?? Icon(widget.iconData, size: widget.iconSize, color: widget.iconColor);
        content = Row(
          mainAxisSize: MainAxisSize.min,
          children: widget.iconPosition == RzButtonIconPosition.left
              ? [iconWidget, SizedBox(width: widget.gap), textWidget]
              : [textWidget, SizedBox(width: widget.gap), iconWidget],
        );
      } else {
        content = textWidget;
      }
    }

    final button = ElevatedButton(
      onPressed: disabled ? null : _handlePress,
      style: btnStyle,
      child: content,
    );

    final result = widget.fullWidth ? SizedBox(width: double.infinity, child: button) : button;
    return widget.margin != null ? Padding(padding: widget.margin!, child: result) : result;
  }
}

//enum RzButtonIconPosition { left, right }