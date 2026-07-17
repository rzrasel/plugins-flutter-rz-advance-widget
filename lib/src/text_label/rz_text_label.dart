import 'package:flutter/material.dart';

class RzTextLabel extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final double? lineHeight;
  final TextAlign? alignment;
  final int? maxLines;
  final TextDecoration? decoration;

  /// You can use this widget for texts. Inside we are using Text widget but UdText helps you minimizing code.
  const RzTextLabel({
    super.key,
    this.text,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.alignment,
    this.lineHeight,
    this.maxLines,
    this.decoration,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    Color defaultColor = Colors.black;
    double defaultSize = 12;
    FontWeight defaultWeight = FontWeight.w500;

    return Text(
      text ?? "Text",
      key: key,
      overflow: overflow,
      textAlign: alignment,
      maxLines: maxLines,
      style: TextStyle(
        height: lineHeight,
        color: color ?? defaultColor,
        fontSize: fontSize ?? defaultSize,
        fontWeight: fontWeight ?? defaultWeight,
        decoration: decoration,
      ),
    );
  }
}
