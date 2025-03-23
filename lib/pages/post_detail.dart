import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../projects/routes/app_route_constants.dart';
import '../providers/post_detail_provider.dart';
import '../widgets/post_item.dart';

class PostDetail extends StatefulWidget {
  final String postId;

  const PostDetail({super.key, required this.postId});

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final postProvider = Provider.of<PostProvider>(context, listen: false);
    postProvider.setPostId(widget.postId);
    postProvider.fetchPostDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Post Detail"), centerTitle: true),
      body: Consumer<PostProvider>(
        builder: (context, postProvider, child) {
          if (postProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (postProvider.errorMessage != null) {
            return Center(child: Text(postProvider.errorMessage!));
          }

          if (postProvider.post == null) {
            return const Center(child: Text("Failed to load post details"));
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  padding: const EdgeInsets.all(16.0),
                  child: PostItem(
                    post: postProvider.post!,
                    onLikeClicked: () {},
                    onShareClick:
                        () => _copyToClipboard(
                          context,
                          "https://devenvoy.github.io/#/post_detail/${postProvider.postId}",
                        ),
                    onProfileClick: () {
                      GoRouter.of(context).replaceNamed(
                        MyAppRouteConstants.profileRouteName,
                        params: {'userId': postProvider.post!.userId},
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String url) {
    Clipboard.setData(ClipboardData(text: url)).then((_) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("URL copied to clipboard!")));
    });
  }
}
