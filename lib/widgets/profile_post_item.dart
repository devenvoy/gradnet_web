import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../model/post_model.dart';
import 'expandable_richtext.dart';
import 'post_images.dart';

class ProfilePostItem extends StatefulWidget {
  final Post post;
  final VoidCallback onShareClick;

  const ProfilePostItem({
    Key? key,
    required this.post,
    this.onShareClick = _defaultFunction,
  }) : super(key: key);

  static void _defaultFunction() {}

  @override
  State<ProfilePostItem> createState() => _ProfilePostItemState();
}

class _ProfilePostItemState extends State<ProfilePostItem> {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Posted $postedAgo",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    RichTextView(text: widget.post.description),
                  ],
                ),
              ),
            ],
          ),
          if (widget.post.photos.isNotEmpty)
            PostImages(images: widget.post.photos, onLikeClicked: () {}),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Liked by ${widget.post.likes} Users",
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              IconButton(
                onPressed: widget.onShareClick,
                icon: const Icon(Icons.share, size: 28, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
