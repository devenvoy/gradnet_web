import 'package:flutter/material.dart';
import 'package:gradnet_web/widgets/profile/interest_tag.dart';
import 'package:gradnet_web/widgets/profile/section_title.dart';

class InterestsSection extends StatelessWidget {
  final IconData? icon;
  final String? assetIcon;
  final String title;
  final List<String>? data;

  const InterestsSection({
    super.key,
    this.icon,
    this.assetIcon,
    this.title = "Interests",
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (data == null || data!.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          icon: icon,
          assetIcon: assetIcon,
          title: title,
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: data!.map((interest) => InterestTag(text: interest)).toList(),
        ),
      ],
    );
  }
}
