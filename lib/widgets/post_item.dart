import 'package:flutter/material.dart';
import 'package:gradnet_web/widgets/expandable_richtext.dart';
import 'package:gradnet_web/widgets/post_images.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../model/post_model.dart' show Post;

class PostItem extends StatefulWidget {
  final Post post;
  final bool checkProfileEnable;
  final VoidCallback onLikeClicked;
  final VoidCallback onShareClick;
  final VoidCallback onProfileClick;

  const PostItem({
    super.key,
    required this.post,
    this.checkProfileEnable = true,
    this.onLikeClicked = _defaultFunction,
    this.onShareClick = _defaultFunction,
    this.onProfileClick = _defaultFunction,
  });

  static void _defaultFunction() {}

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  String postedAgo = "Loading...";

  @override
  void initState() {
    super.initState();
    _calculateTimeAgo();
  }

  void _calculateTimeAgo() {
    DateTime createdAt = DateTime.parse(widget.post.createdAt);
    setState(() {
      postedAgo = timeago.format(createdAt);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileRow(),
              const SizedBox(height: 8),
              RichTextView(text: widget.post.description),
              if (widget.post.photos.isNotEmpty)
                PostImages(images: widget.post.photos, onLikeClicked: () {}),
              const SizedBox(height: 10),
              _buildActionRow(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileRow() {
    return Row(
      children: [
        GestureDetector(
          onTap: widget.checkProfileEnable ? widget.onProfileClick : null,
          child: CircleAvatar(
            radius: 18,
            backgroundImage:
                widget.post.userProfilePic != null
                    ? NetworkImage(widget.post.userProfilePic)
                    : null,
            child:
                widget.post.userProfilePic == null
                    ? Text(widget.post.userName[0])
                    : null,
          ),
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: widget.checkProfileEnable ? widget.onProfileClick : null,
              child: Text(
                widget.post.userName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Text(
              " • $postedAgo",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: widget.onLikeClicked,
          icon: Icon(
            Icons.favorite,
            /*widget.post.isLiked ? Icons.favorite : Icons.favorite_border*/
            color:
                Colors.red /*widget.post.isLiked ? Colors.red : Colors.grey,*/,
          ),
        ),
        Text(widget.post.likes.toString()),
        const SizedBox(width: 10),
        /*IconButton(
          onPressed: widget.onShareClick,
          icon: const Icon(Icons.share, color: Colors.grey),
        ),*/
      ],
    );
  }
}
