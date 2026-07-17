import 'package:flutter/material.dart';

class RzFieldset extends StatelessWidget {
  const RzFieldset({
    super.key,
    required this.child,
    this.title,
    this.titleWidget,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.only(top: 12),
    this.borderRadius = 8,
    this.borderColor = Colors.grey,
    this.backgroundColor,
  });

  final Widget child;

  final String? title;
  final Widget? titleWidget;

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  final double borderRadius;
  final Color borderColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final Widget? legend =
        titleWidget ??
        (title != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Text(
                  title!,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              )
            : null);

    return Container(
      margin: margin,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: legend != null
                ? const EdgeInsets.only(top: 10)
                : EdgeInsets.zero,
            padding: padding,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: child,
          ),
          if (legend != null) Positioned(left: 12, top: 0, child: legend),
        ],
      ),
    );
  }
}
