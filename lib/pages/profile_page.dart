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

  @override
  void initState() {
    super.initState();
    userProfileFuture = ProfileScreenProvider().getUserProfile(widget.userId);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

        return Scaffold(
          appBar: TopAppBarView(
            userProfile: userProfile,
            isVisible: true,
            onMenuClick: () {},
          ),
          body: Stack(
            children: [
              TopBackground(backgroundPic: userProfile.backgroundPic ?? "", height: 200),
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    const SizedBox(height: 120),
                    TopScrollingContent(userProfile: userProfile, scrollController: _scrollController),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Theme.of(context).colorScheme.surface,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userProfile.name, style: Theme.of(context).textTheme.titleLarge),
                          Text(userProfile.email, style: Theme.of(context).textTheme.bodyMedium),
                          if (userProfile.designation != null)
                            Text(userProfile.designation!, style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          TabBar(
                            indicator: FancyIndicator(color: Colors.blue[300]!),
                            tabs: const [
                              Tab(text: 'Posts'),
                              Tab(text: 'Details'),
                            ],
                          ),
                          SizedBox(
                            height: 400,
                            child: TabBarView(
                              children: [
                                UserPostsContent(),
                                UserDetailsContent(userProfile: userProfile),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}



class UserPostsContent extends StatelessWidget {
  const UserPostsContent({super.key});

  double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: getScreenHeight(context) / 2);
  }
}































class UserDetailsContent extends StatelessWidget {
  final UserProfileResponse userProfile;

  const UserDetailsContent({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
              margin: EdgeInsets.all(10),
              color: Theme.of(context).cardColor,
              elevation: 1,
              child: Column(
                children: userProfile.education
                    .map((education) => EducationItem(education: education))
                    .toList(),
              ),
            ),
          ],

          if (userProfile.experience.isNotEmpty) ...[
            SectionTitle(icon: Icons.work_outline, title: "Experience"),
            Card(
              margin: EdgeInsets.all(10),
              color: Theme.of(context).cardColor,
              elevation: 1,
              child: Column(
                children: userProfile.experience
                    .map((experience) => ExperienceItem(experience: experience))
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
        ],
      ),
    );
  }
}
