import 'package:flutter/material.dart';
import 'package:gradnet_web/widgets/loading_animation.dart';
import 'package:provider/provider.dart';
import '../providers/profile_screen_provider.dart';
import '../widgets/post_item.dart';

class PostPage extends StatefulWidget {
  final String userId;

  const PostPage({super.key, required this.userId});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileScreenProvider>(context, listen: false)
          .fetchUserPosts(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileScreenProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Gradnet Web App")),
      body: profileProvider.isLoading
          ? Center(
              child: LoadingAnimation()
            )
          : profileProvider.posts.isEmpty
              ? const Center(child: Text("No posts available"))
              : ListView.builder(
                  itemCount: profileProvider.posts.length,
                  itemBuilder: (context, index) {
                    return PostItem(post: profileProvider.posts[index]);
                  },
                ),
    );
  }
}
