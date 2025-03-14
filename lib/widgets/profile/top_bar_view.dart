import 'package:flutter/material.dart';
import 'package:gradnet_web/model/profile_model.dart';
import 'package:gradnet_web/widgets/profile/circle_image.dart';

class TopAppBarView extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuClick;
  final UserProfileResponse userProfile;

  const TopAppBarView({
    super.key,
    required this.onMenuClick,
    required this.userProfile,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity:1.0,
      duration: const Duration(milliseconds: 600),
      child: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(userProfile.name.isNotEmpty ? userProfile.name : "User"),
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: CircularProfileImage(
            placeHolderName: userProfile.name.isNotEmpty ? userProfile.name : "User",
            imageUrl: userProfile.profilePic,
            borderWidth: 0,
            imageSize: 32,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
