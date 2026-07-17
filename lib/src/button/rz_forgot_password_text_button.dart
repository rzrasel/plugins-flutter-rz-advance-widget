import 'package:flutter/material.dart';

class RzForgotPasswordTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  // Colors - you asked for these
  final Color fontColor;
  final Color backgroundColor;
  final Color borderColor;

  // Style
  final FontWeight fontWeight;
  final double fontSize;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Alignment alignment;

  // Underline
  final bool underline;
  final double underlineThickness;
  final double underlineGap;

  const RzForgotPasswordTextButton({
    super.key,
    this.text = 'Forgot Password?',
    this.onPressed,
    // Colors
    this.fontColor = const Color(0xFF2196F3),
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.transparent,
    // Style
    this.fontWeight = FontWeight.w500,
    this.fontSize = 14.0,
    this.borderWidth = 1.0,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.alignment = Alignment.centerRight,
    this.underline = false,
    this.underlineThickness = 1.2,
    this.underlineGap = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null;

    return Align(
      alignment: alignment,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: padding,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: Size.zero,
        ),
        child: Container(
          padding: EdgeInsets.only(bottom: underline ? underlineGap : 0),
          decoration: underline
              ? BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isDisabled ? Colors.grey : fontColor,
                width: underlineThickness,
              ),
            ),
          )
              : null,
          child: Text(
            text,
            style: TextStyle(
              color: isDisabled ? Colors.grey : fontColor,
              fontWeight: fontWeight,
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
/*
Usages:
RzForgotPasswordTextButton(
  text: 'Forgot Password?',
  alignment: Alignment.centerLeft,
  fontColor: Colors.white,
  backgroundColor: Colors.black,
  borderColor: Colors.black,
  borderRadius: 10,
  borderWidth: 1.0,
  fontWeight: FontWeight.w600,
  fontSize: 13,
  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  underline: true,
  underlineGap: 1.0,
  underlineThickness: 1.0,
  onPressed: () {},
),
*/