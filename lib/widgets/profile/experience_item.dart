import 'package:flutter/material.dart';
import 'package:gradnet_web/model/profile_model.dart';

class ExperienceItem extends StatelessWidget {
  final ExperienceDto experience;

  const ExperienceItem({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Job Title
                Text(
                  experience.jobTitle,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                ),

                // Company and Location
                if (experience.companyName != null && experience.companyName!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      "${experience.companyName}${experience.location != null && experience.location!.isNotEmpty ? " • ${experience.location}" : ""}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),

                // Duration
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    "${experience.startDate ?? ""} - ${experience.endDate ?? "Present"}",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),

                // Description
                if (experience.jobDescription != null && experience.jobDescription!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      experience.jobDescription!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
