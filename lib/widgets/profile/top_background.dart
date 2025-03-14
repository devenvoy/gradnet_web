import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gradnet_web/constants/constants.dart';

class TopBackground extends StatelessWidget {
  final String backgroundPic;
  final double height;

  const TopBackground({
    super.key,
    required this.backgroundPic,
    this.height = 170.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        SizedBox(
          height: height,
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl: backgroundPic.isNotEmpty ? backgroundPic : dummyBgImage,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(color: Colors.grey),
            errorWidget: (context, url, error) => Container(color: Colors.grey),
          ),
        ),

        // Gradient Overlay
        Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.8),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
