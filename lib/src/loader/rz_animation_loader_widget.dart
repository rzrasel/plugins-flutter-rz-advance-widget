import 'package:flutter/material.dart';

class RzAnimationLoaderWidget extends StatelessWidget {
  const RzAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
    this.width,
    this.height,
    this.actionButtonWidth = 250,
    this.style,
    this.defaultSpace = 24.0,
  });

  final String text;
  final TextStyle? style;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;
  final double? width;
  final double? height;
  final double actionButtonWidth;
  final double defaultSpace;

  bool get _canShowAction =>
      showAction &&
          actionText != null &&
          actionText!.trim().isNotEmpty &&
          onActionPressed != null;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          //Lottie.asset(animation, width: width, height: height ?? MediaQuery.of(context).size.height * 0.5,),
          SizedBox(height: defaultSpace,),
          Text(
            text,
            style: style ?? Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          if (_canShowAction) ...[
            SizedBox(height: defaultSpace),
            SizedBox(
              width: actionButtonWidth,
              child: OutlinedButton(
                onPressed: onActionPressed,
                child: Text(
                  actionText!,
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}