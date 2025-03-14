import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gradnet_web/model/profile_model.dart';

class TopScrollingContent extends StatefulWidget {
  final UserProfileResponse userProfile;
  final ScrollController scrollController;

  const TopScrollingContent({
    super.key,
    required this.userProfile,
    required this.scrollController,
  });

  @override
  _TopScrollingContentState createState() => _TopScrollingContentState();
}

class _TopScrollingContentState extends State<TopScrollingContent> {
  double imageSize = 120.0;
  double opacity = 1.0;
  
  get dummyProfilePic => null;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_updateSizeAndOpacity);
  }

  void _updateSizeAndOpacity() {
    double offset = widget.scrollController.offset;
    double newSize = (120.0 - (offset * 0.5)).clamp(42.0, 120.0);
    double newOpacity = (1 - (offset / 200)).clamp(0.0, 1.0);

    setState(() {
      imageSize = newSize;
      opacity = newOpacity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
          margin: EdgeInsets.only(left: 12.0),
          width: imageSize,
          height: imageSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey, width: 2),
          ),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: widget.userProfile.profilePic ?? dummyProfilePic,
              fit: BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.person),
            ),
          ),
        ),
        SizedBox(width: 8),
        AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: opacity,
          child: Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userProfile.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // TODO: Add badges here
              ],
            ),
          ),
        ),
      ],
    );
  }
}
