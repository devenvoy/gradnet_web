import 'package:flutter/material.dart';
import 'package:gradnet_web/model/profile_model.dart';
import 'package:gradnet_web/widgets/profile/circle_image.dart';

class TopAppBarView extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onMenuClick;
  final UserProfileResponse userProfile;

  const TopAppBarView({
    super.key,
    required this.isVisible,
    required this.onMenuClick,
    required this.userProfile,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 600),
      child: AppBar(
        title: Text(userProfile.name.isNotEmpty ? userProfile.name : userProfile.name),
        leading: Padding(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: CircularProfileImage(
            placeHolderName: userProfile.name.isNotEmpty ? userProfile.name : userProfile.name,
            imageUrl: userProfile.profilePic,
            borderWidth: 0,
            imageSize: 32,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: onMenuClick,
          ),
        ],
      ),
    );
  }
}
