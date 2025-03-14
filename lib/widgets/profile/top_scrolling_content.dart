import 'package:flutter/material.dart';
import 'package:gradnet_web/model/profile_model.dart';
import 'circle_image.dart';

class TopScrollingContent extends StatelessWidget {
  final UserProfileResponse userProfile;
  final ScrollController scrollController;

  const TopScrollingContent({
    super.key,
    required this.userProfile,
    required this.scrollController,
  });

  static const double initialImageSize = 120.0;
  static const double minImageSize = 42.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        double scrollOffset = scrollController.offset * 2;
        double dynamicSize = (initialImageSize - scrollOffset).clamp(
          minImageSize,
          initialImageSize,
        );
        double opacityValue = (1 - (scrollOffset / (initialImageSize * 2)))
            .clamp(0.0, 1.0);

        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: CircularProfileImage(
                imageSize: dynamicSize,
                imageUrl: userProfile.profilePic,
                placeHolderName: userProfile.name,
              ),
            ),
            SizedBox(width: 8),
            AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: opacityValue,
              child: Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TODO: Add badges here
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
