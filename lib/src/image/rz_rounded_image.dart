import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';
import 'rz_image_type.dart';
import '../shimmer_effect/rz_shimmer_effect.dart';

class RzRoundedImage extends StatelessWidget {
  const RzRoundedImage({
    super.key,
    this.image,
    this.file,
    this.memoryImage,
    required this.imageType,
    this.border,
    this.borderRadius = 8,
    this.applyImageRadius = true,
    this.width = 56,
    this.height = 56,
    this.fit = BoxFit.contain,
    this.padding = 8,
    this.margin,
    this.overlayColor,
    this.backgroundColor,
  });

  final String? image;
  final File? file;
  final Uint8List? memoryImage;
  final RzImageType imageType;
  final BoxBorder? border;
  final double borderRadius;
  final bool applyImageRadius;
  final double width;
  final double height;
  final BoxFit? fit;
  final double padding;
  final double? margin;
  final Color? overlayColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      margin: margin != null ? EdgeInsets.all(margin!) : null,
      decoration: BoxDecoration(
        border: border,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: _buildImageWidget(),
    );
  }

  Widget _buildImageWidget() {
    Widget imageWidget;
    switch (imageType) {
      case RzImageType.network:
        imageWidget = _buildNetworkImage();
        break;
      case RzImageType.memory:
        imageWidget = _buildMemoryImage();
        break;
      case RzImageType.file:
        imageWidget = _buildFileImage();
        break;
      case RzImageType.asset:
        imageWidget = _buildAssetImage();
        break;
    }

    return ClipRRect(
      borderRadius: applyImageRadius ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
      child: imageWidget,
    );
  }

  Widget _buildNetworkImage() {
    if(image != null) {
      return CachedNetworkImage(
        fit: fit,
        color: overlayColor,
        imageUrl: image!,
        errorWidget: (context, url, error) => Icon(Icons.error),
        progressIndicatorBuilder: (context, url, downloadProgress) => RzShimmerEffect(width: width, height: height),
      );
    }
    return SizedBox();
  }

  Widget _buildMemoryImage() {
    if(memoryImage != null) {
      return Image(
        fit: fit,
        image: MemoryImage(memoryImage!),
        color: overlayColor,
      );
    }
    return SizedBox();
  }

  Widget _buildFileImage() {
    if(file != null) {
      return Image(
        fit: fit,
        image: FileImage(file!),
        color: overlayColor,
      );
    }
    return SizedBox();
  }

  Widget _buildAssetImage() {
    if(image != null) {
      return Image(
        fit: fit,
        image: AssetImage(image!),
        color: overlayColor,
      );
    }
    return Container();
  }
}
