import 'package:flutter/material.dart';
import '../shimmer/rz_shimmer.dart';

class RzShimmerEffect extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const RzShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return RzShimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }
}