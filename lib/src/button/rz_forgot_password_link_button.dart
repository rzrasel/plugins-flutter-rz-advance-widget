import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RzForgotPasswordLinkButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;

  final Color fontColor;
  final Color backgroundColor;
  final Color borderColor;

  final FontWeight fontWeight;
  final double fontSize;
  final double borderWidth;
  final double borderRadius;

  final bool underline;
  final double underlineThickness;
  final double underlineGap; // <-- now working

  final EdgeInsetsGeometry padding;
  final Alignment alignment;
  final bool enabled;

  const RzForgotPasswordLinkButton({
    super.key,
    this.text = 'Forgot Password?',
    this.onPressed,
    this.fontColor = const Color(0xFF2196F3),
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.transparent,
    this.fontWeight = FontWeight.w500,
    this.fontSize = 14.0,
    this.borderWidth = 1.0,
    this.borderRadius = 8.0,
    this.underline = false,
    this.underlineThickness = 1.2,
    this.underlineGap = 2.0,
    this.padding = EdgeInsets.zero,
    this.alignment = Alignment.centerRight,
    this.enabled = true,
  });

  @override
  State<RzForgotPasswordLinkButton> createState() => _RzForgotPasswordLinkButtonState();
}

class _RzForgotPasswordLinkButtonState extends State<RzForgotPasswordLinkButton> {
  late TapGestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();
    _recognizer = TapGestureRecognizer()..onTap = widget.onPressed;
  }

  @override
  void didUpdateWidget(covariant RzForgotPasswordLinkButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _recognizer.onTap = widget.onPressed;
  }

  @override
  void dispose() {
    _recognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = !widget.enabled || widget.onPressed == null;

    // This is the fix - underline via Container, not TextStyle
    Widget richText = RichText(
      text: TextSpan(
        text: widget.text,
        style: TextStyle(
          color: isDisabled ? Colors.grey : widget.fontColor,
          fontWeight: widget.fontWeight,
          fontSize: widget.fontSize,
        ),
        recognizer: isDisabled ? null : _recognizer,
      ),
    );

    if (widget.underline) {
      richText = Container(
        padding: EdgeInsets.only(bottom: widget.underlineGap),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isDisabled ? Colors.grey : widget.fontColor,
              width: widget.underlineThickness,
            ),
          ),
        ),
        child: richText,
      );
    }

    return Align(
      alignment: widget.alignment,
      child: MouseRegion(
        cursor: isDisabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
        child: Container(
          padding: widget.padding,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(color: widget.borderColor, width: widget.borderWidth),
          ),
          child: richText,
        ),
      ),
    );
  }
}
/*
Usages:
RzForgotPasswordLinkButton(
  text: 'Forgot Password?',
  alignment: Alignment.centerRight,
  fontColor: Colors.black,
  backgroundColor: Colors.transparent,
  borderColor: Colors.transparent,
  borderRadius: 10,
  borderWidth: 1.0,
  fontWeight: FontWeight.w600,
  fontSize: 13,
  // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  padding: EdgeInsets.zero,
  underline: true,
  underlineGap: 1.0,
  underlineThickness: 1.0,
  onPressed: () {},
),
*/