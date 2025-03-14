import 'package:flutter/material.dart';

class AboutMeSection extends StatelessWidget {
  final String about;

  const AboutMeSection({super.key, required this.about});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title with Icon
        Row(
          children: [
            Icon(Icons.person_outline, color: Theme.of(context).colorScheme.primary),
            SizedBox(width: 8),
            Text(
              "About Me",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        // About Me Content
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            about,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
