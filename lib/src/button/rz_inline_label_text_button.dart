import 'package:flutter/material.dart';

class RzInlineLabelTextButton extends StatelessWidget {
  final String labelText;
  final String buttonText;
  final VoidCallback? onPressed;

  final Color labelColor;
  final FontWeight labelFontWeight;
  final double labelFontSize;

  final Color buttonColor;
  final FontWeight buttonFontWeight;
  final double buttonFontSize;

  final MainAxisAlignment alignment;
  final double gap;
  final bool underlineButton;
  final double underlineGap; // <-- position control
  final double underlineThickness;
  final EdgeInsetsGeometry buttonPadding;

  const RzInlineLabelTextButton({
    super.key,
    required this.labelText,
    required this.buttonText,
    this.onPressed,
    this.labelColor = const Color(0xFF757575),
    this.labelFontWeight = FontWeight.w400,
    this.labelFontSize = 14.0,
    this.buttonColor = const Color(0xFF2196F3),
    this.buttonFontWeight = FontWeight.w700,
    this.buttonFontSize = 14.0,
    this.alignment = MainAxisAlignment.center,
    this.gap = 2.0,
    this.underlineButton = false,
    this.underlineGap = 2.0,
    this.underlineThickness = 1.2,
    this.buttonPadding = const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null;

    Widget buttonChild;

    if (underlineButton) {
      // Custom underline - position controllable
      buttonChild = Container(
        padding: EdgeInsets.only(bottom: underlineGap),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isDisabled ? Colors.grey : buttonColor,
              width: underlineThickness,
            ),
          ),
        ),
        child: Text(
          buttonText.trim(),
          style: TextStyle(
            color: isDisabled ? Colors.grey : buttonColor,
            fontWeight: buttonFontWeight,
            fontSize: buttonFontSize,
          ),
        ),
      );
    } else {
      buttonChild = Text(
        buttonText.trim(),
        style: TextStyle(
          color: isDisabled ? Colors.grey : buttonColor,
          fontWeight: buttonFontWeight,
          fontSize: buttonFontSize,
        ),
      );
    }

    return Row(
      mainAxisAlignment: alignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            labelText.trim(),
            style: TextStyle(
              color: labelColor,
              fontWeight: labelFontWeight,
              fontSize: labelFontSize,
            ),
          ),
        ),
        SizedBox(width: gap),
        MouseRegion(
          cursor: isDisabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              padding: buttonPadding,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: buttonChild,
          ),
        ),
      ],
    );
  }
}
/*
Usages:
RzInlineLabelTextButton(
  labelText: "Don't have an account?",
  buttonText: "Sign up",
  buttonColor: Colors.black,
  gap: 20,
  underlineButton: true,
  underlineGap: 1.0,
  underlineThickness: 1.0,
  onPressed: () => Navigator.pushNamed(context, '/signup'),
),
*/