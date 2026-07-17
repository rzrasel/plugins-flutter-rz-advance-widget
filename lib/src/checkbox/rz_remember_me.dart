import 'package:flutter/material.dart';

class RzRememberMe extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String labelText;

  final Color labelColor;
  final FontWeight labelFontWeight;
  final double labelFontSize;

  // NEW - 4 colors
  final Color checkedBorderColor;
  final Color uncheckedBorderColor;
  final Color checkedBackgroundColor;
  final Color uncheckedBackgroundColor;
  final Color tickColor;

  final double borderWidth;
  final double size;
  final double gap;
  final double borderRadius;
  final bool enabled;

  const RzRememberMe({
    super.key,
    required this.value,
    required this.onChanged,
    this.labelText = 'Remember me',
    this.labelColor = const Color(0xFF424242),
    this.labelFontWeight = FontWeight.w400,
    this.labelFontSize = 14.0,
    // defaults
    this.checkedBorderColor = const Color(0xFF2196F3),
    this.uncheckedBorderColor = const Color(0xFF9E9E9E),
    this.checkedBackgroundColor = const Color(0xFF2196F3),
    this.uncheckedBackgroundColor = Colors.transparent,
    this.tickColor = Colors.white,
    this.borderWidth = 1.5,
    this.size = 20.0,
    this.gap = 8.0,
    this.borderRadius = 4.0,
    this.enabled = true,
  });

  @override
  State<RzRememberMe> createState() => _RzRememberMeState();
}

class _RzRememberMeState extends State<RzRememberMe> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(covariant RzRememberMe oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) _value = widget.value;
  }

  void _toggle() {
    if (!widget.enabled) return;
    setState(() => _value = !_value);
    widget.onChanged(_value);
  }

  @override
  Widget build(BuildContext context) {
    final double scale = widget.size / 20.0;

    return Opacity(
      opacity: widget.enabled ? 1.0 : 0.6,
      child: MouseRegion(
        cursor: widget.enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: _toggle,
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.scale(
                scale: scale,
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: Checkbox(
                    value: _value,
                    onChanged: widget.enabled
                        ? (v) {
                      setState(() => _value = v ?? false);
                      widget.onChanged(v);
                    }
                        : null,
                    // Background color
                    activeColor: widget.checkedBackgroundColor,
                    checkColor: widget.tickColor,
                    side: BorderSide(
                      color: _value ? widget.checkedBorderColor : widget.uncheckedBorderColor,
                      width: widget.borderWidth,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ),
              SizedBox(width: widget.gap),
              Flexible(
                child: Text(
                  widget.labelText,
                  style: TextStyle(
                    color: widget.labelColor,
                    fontWeight: widget.labelFontWeight,
                    fontSize: widget.labelFontSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
Usages:
RzRememberMe(
  value: false,
  labelText: "Remember me",
  labelColor: Colors.black87,
  labelFontWeight: FontWeight.w500,
  labelFontSize: 13,
  checkedBorderColor: Colors.green,
  uncheckedBorderColor: Colors.grey,
  checkedBackgroundColor: Colors.green,
  uncheckedBackgroundColor: Colors.white,
  tickColor: Colors.white,
  borderRadius: 4,
  size: 22,
  borderWidth: 1.0,
  gap: 8.0,
  onChanged: (v) {
    print(v);
  },
),
*/