import 'package:flutter/material.dart';
import 'package:gradnet_web/model/profile_model.dart';
import 'package:gradnet_web/widgets/profile/about_me.dart';
import 'package:gradnet_web/widgets/profile/education_item.dart';
import 'package:gradnet_web/widgets/profile/experience_item.dart';
import 'package:gradnet_web/widgets/profile/interest_section.dart';
import 'package:gradnet_web/widgets/profile/more_info_section.dart';
import 'package:gradnet_web/widgets/profile/section_title.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
