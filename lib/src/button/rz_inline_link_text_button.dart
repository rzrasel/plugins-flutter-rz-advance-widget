import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RzInlineLinkTextButton extends StatefulWidget {
  final String labelText;
  final String buttonText;
  final VoidCallback? onPressed;

  final Color? labelColor;
  final FontWeight labelFontWeight;
  final double labelFontSize;
  final double? labelHeight;
  final double? labelLetterSpacing;

  final Color? buttonColor;
  final FontWeight buttonFontWeight;
  final double buttonFontSize;
  final double? buttonHeight;

  final bool underlineButton;
  final double underlineGap;
  final double underlineThickness;
  final double gap;
  final TextAlign textAlign;
  final bool center;

  const RzInlineLinkTextButton({
    super.key,
    required this.labelText,
    required this.buttonText,
    this.onPressed,
    this.labelColor = const Color(0xFF757575),
    this.labelFontWeight = FontWeight.w400,
    this.labelFontSize = 14.0,
    this.labelHeight,
    this.labelLetterSpacing,
    this.buttonColor = const Color(0xFF2196F3),
    this.buttonFontWeight = FontWeight.w700,
    this.buttonFontSize = 14.0,
    this.buttonHeight,
    this.underlineButton = false,
    this.underlineGap = 2.0,
    this.underlineThickness = 1.2,
    this.gap = 6.0,
    this.textAlign = TextAlign.center,
    this.center = true,
  });

  @override
  State<RzInlineLinkTextButton> createState() => _RzInlineLinkTextState();
}

class _RzInlineLinkTextState extends State<RzInlineLinkTextButton> {
  late TapGestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();
    _recognizer = TapGestureRecognizer()..onTap = widget.onPressed;
  }

  @override
  void didUpdateWidget(covariant RzInlineLinkTextButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.onPressed != widget.onPressed) {
      _recognizer.onTap = widget.onPressed;
    }
  }

  @override
  void dispose() {
    _recognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = widget.onPressed == null;
    final effectiveButtonColor = widget.buttonColor ?? theme.colorScheme.primary;
    final effectiveLabelColor = widget.labelColor ?? const Color(0xFF757575);

    InlineSpan buttonSpan;

    if (widget.underlineButton) {
      buttonSpan = WidgetSpan(
        alignment: PlaceholderAlignment.baseline,
        baseline: TextBaseline.alphabetic,
        child: MouseRegion(
          cursor: isDisabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
          child: GestureDetector(
            onTap: widget.onPressed,
            child: Container(
              padding: EdgeInsets.only(bottom: widget.underlineGap),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isDisabled ? Colors.grey : effectiveButtonColor,
                    width: widget.underlineThickness,
                  ),
                ),
              ),
              child: Text(
                widget.buttonText.trim(),
                style: TextStyle(
                  color: isDisabled ? Colors.grey : effectiveButtonColor,
                  fontWeight: widget.buttonFontWeight,
                  fontSize: widget.buttonFontSize,
                  height: widget.buttonHeight,
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      buttonSpan = TextSpan(
        text: widget.buttonText.trim(),
        style: TextStyle(
          color: isDisabled ? Colors.grey : effectiveButtonColor,
          fontWeight: widget.buttonFontWeight,
          fontSize: widget.buttonFontSize,
          height: widget.buttonHeight ?? widget.labelHeight,
        ),
        recognizer: isDisabled ? null : _recognizer,
        mouseCursor: isDisabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
      );
    }

    final richText = RichText(
      textAlign: widget.textAlign,
      text: TextSpan(
        text: widget.labelText.trim(),
        style: TextStyle(
          color: effectiveLabelColor,
          fontWeight: widget.labelFontWeight,
          fontSize: widget.labelFontSize,
          height: widget.labelHeight,
          letterSpacing: widget.labelLetterSpacing,
        ),
        children: [
          WidgetSpan(child: SizedBox(width: widget.gap)),
          buttonSpan,
        ],
      ),
    );

    return Semantics(
      button: true,
      enabled: !isDisabled,
      label: '${widget.labelText} ${widget.buttonText}',
      child: widget.center ? Center(child: richText) : richText,
    );
  }
}
/*
Usages:
RzInlineLinkTextButton(
  labelText: "Don't have an account?",
  buttonText: "Sign up",
  buttonColor: Colors.black,
  gap: 2,
  underlineButton: true,
  underlineGap: 1.0,
  underlineThickness: 1.0,
  alignment: MainAxisAlignment.center,
  onPressed: () => Navigator.pushNamed(context, '/signup'),
),
*/