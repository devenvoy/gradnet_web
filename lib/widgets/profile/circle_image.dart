import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CircularProfileImage extends StatelessWidget {
  final String placeHolderName;
  final String? imageUrl;
  final double imageSize;
  final Color borderColor;
  final double borderWidth;
  final Color backgroundColor;

  const CircularProfileImage({
    super.key,
    required this.placeHolderName,
    this.imageUrl,
    this.imageSize = 70.0,
    this.borderColor = Colors.white,
    this.borderWidth = 2.0,
    this.backgroundColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    final String placeholderUrl =
        "https://ui-avatars.com/api/?name=$placeHolderName&background=ECEFF1";

    return Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: ClipOval(
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                placeholder: (context, url) => Image.network(placeholderUrl, fit: BoxFit.cover),
                errorWidget: (context, url, error) => Image.network(placeholderUrl, fit: BoxFit.cover),
                fit: BoxFit.cover,
              )
            : Image.network(placeholderUrl, fit: BoxFit.cover),
      ),
    );
  }
}
