import 'package:flutter/material.dart';
import 'package:gradnet_web/widgets/post_item.dart';
import 'package:provider/provider.dart';

import '../providers/post_detail_provider.dart';

class PostDetail extends StatelessWidget {
  final String postId;

  const PostDetail({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    postProvider.setPostId(postId);
    postProvider.fetchPostDetails();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Detail"),
        centerTitle: true,
      ),
      body: Consumer<PostProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.post == null) {
            return const Center(child: Text("Failed to load post details"));
          }
          return LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 800),
                  padding: const EdgeInsets.all(16.0),
                  child: PostItem(
                    post: provider.post!,
                    onLikeClicked: () {},
                    onShareClick: () {},
                    onProfileClick: () {},
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}