import 'package:flutter/material.dart';
import 'package:gradnet_web/model/profile_model.dart';
import 'package:gradnet_web/providers/profile_screen_provider.dart';
import 'package:gradnet_web/widgets/profile/about_me.dart';
import 'package:gradnet_web/widgets/profile/education_item.dart';
import 'package:gradnet_web/widgets/profile/experience_item.dart';
import 'package:gradnet_web/widgets/profile/fancy_indicator.dart';
import 'package:gradnet_web/widgets/profile/interest_section.dart';
import 'package:gradnet_web/widgets/profile/more_info_section.dart';
import 'package:gradnet_web/widgets/profile/section_title.dart';
import 'package:gradnet_web/widgets/profile/top_background.dart';
import 'package:gradnet_web/widgets/profile/top_scrolling_content.dart';
import 'package:provider/provider.dart';
import '../providers/post_screen_provider.dart';
import '../widgets/loading_animation.dart';
import '../widgets/post_item.dart';
import '../widgets/profile/top_bar_view.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<UserProfileResponse> userProfileFuture;
  final ScrollController _scrollController = ScrollController();
  bool _showAppBar = false; // Initially hidden

  @override
  void initState() {
    super.initState();

    userProfileFuture = ProfileScreenProvider().getUserProfile(widget.userId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostScreenProvider>(context, listen: false)
          .fetchUserPosts(widget.userId);
    });

    // Listen to scroll changes
    _scrollController.addListener(() {
      double scrollPosition = _scrollController.offset;
      double threshold =
          180; // Adjust this based on when you want to show the app bar

      if (scrollPosition >= threshold && !_showAppBar) {
        setState(() {
          _showAppBar = true;
        });
      } else if (scrollPosition < threshold && _showAppBar) {
        setState(() {
          _showAppBar = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostScreenProvider>(context);

    return FutureBuilder<UserProfileResponse>(
      future: userProfileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('User not found'));
        }

        final userProfile = snapshot.data!;
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(56), // Standard app bar height
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: _showAppBar ? 1.0 : 0.0,
                child:
                    _showAppBar
                        ? TopAppBarView(
                          userProfile: userProfile,
                          onMenuClick: () {},
                        )
                        : SizedBox.shrink(),
              ),
            ),
            body: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Stack(
                      children: [
                        TopBackground(
                          backgroundPic: userProfile.backgroundPic ?? "",
                          height: 200,
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 120),
                            TopScrollingContent(
                              userProfile: userProfile,
                              scrollController: _scrollController,
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(8.0),
                              color: Theme.of(context).colorScheme.surface,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userProfile.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    userProfile.designation ??
                                        (userProfile.course ??
                                            userProfile.email),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                        labelColor: Colors.blue[300]!,
                        unselectedLabelColor:
                            Theme.of(context).colorScheme.onSurface,
                        indicator: FancyIndicator(color: Colors.blue[300]!),
                        tabs: const [Tab(text: 'Posts'), Tab(text: 'Details')],
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  UserPostsContent(postProvider),
                  UserDetailsContent(userProfile: userProfile),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class UserPostsContent extends StatelessWidget {
  PostScreenProvider postProvider;
  UserPostsContent(this.postProvider, {super.key});

  @override
  Widget build(BuildContext context) {
    return postProvider.isLoading
        ? Center(
        child: LoadingAnimation()
    )
        : postProvider.posts.isEmpty
        ? const Center(child: Text("No posts available"))
        : ListView.builder(
      itemCount: postProvider.posts.length,
      itemBuilder: (context, index) {
        return PostItem(post: postProvider.posts[index]);
      },
    );
  }
}

class UserDetailsContent extends StatelessWidget {
  final UserProfileResponse userProfile;

  const UserDetailsContent({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        AboutMeSection(about: userProfile.aboutSelf.toString()),
        InterestsSection(
          icon: Icons.computer,
          title: "Skills",
          data: userProfile.skills,
        ),
        if (userProfile.education.isNotEmpty) ...[
          SectionTitle(icon: Icons.school, title: "Education"),
          Card(
            color: Theme.of(context).cardColor,
            elevation: 1,
            child: Column(
              children:
                  userProfile.education
                      .map((education) => EducationItem(education: education))
                      .toList(),
            ),
          ),
        ],
        if (userProfile.experience.isNotEmpty) ...[
          SectionTitle(icon: Icons.work_outline, title: "Experience"),
          Card(
            color: Theme.of(context).cardColor,
            elevation: 1,
            child: Column(
              children:
                  userProfile.experience
                      .map(
                        (experience) => ExperienceItem(experience: experience),
                      )
                      .toList(),
            ),
          ),
        ],
        InterestsSection(
          icon: Icons.translate,
          title: "Languages",
          data: userProfile.languages,
        ),
        MoreInfoSection(
          phoneNumber: userProfile.phoneNo.toString(),
          email: userProfile.email,
          socialUrls: userProfile.urls,
        ),
        const SizedBox(height: 200),
      ],
    );
  }
}
