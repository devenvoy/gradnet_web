import 'package:flutter/material.dart';
import 'package:gradnet_web/model/profile_model.dart';

class EducationItem extends StatelessWidget {
  final EducationDto education;

  const EducationItem({super.key, required this.education});

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
                // School name
                Text(
                  education.schoolName,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                ),

                // Degree and Field
                if (education.degree != null && education.degree!.isNotEmpty)
                  Text(
                    "${education.degree}${education.fieldOfStudy != null && education.fieldOfStudy!.isNotEmpty ? ", ${education.fieldOfStudy}" : ""}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                // Location
                if (education.location != null && education.location!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      education.location!,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ),

                // Duration
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    "${education.startDate ?? ""} - ${education.endDate ?? "Present"}",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),

                // Description
                if (education.description != null && education.description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      education.description!,
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
