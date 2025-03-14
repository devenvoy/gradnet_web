import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BackgroundImage extends StatelessWidget {
  final String? imageUrl;
  final Color backgroundColor;
  final double height;
  final BorderRadius borderRadius;

  const BackgroundImage({
    super.key,
    this.imageUrl,
    this.backgroundColor = Colors.grey,
    this.height = 120.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        width: double.infinity,
        height: height,
        color: backgroundColor,
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                placeholder: (context, url) => Container(
                  color: backgroundColor,
                ),
                errorWidget: (context, url, error) => Container(
                  color: backgroundColor,
                ),
                fit: BoxFit.cover,
              )
            : Container(color: backgroundColor),
      ),
    );
  }
}
