import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final IconData? icon;
  final String? assetIcon;
  final String title;

  const SectionTitle({
    super.key,
    this.icon,
    this.assetIcon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(icon, size: 20, color: Theme.of(context).colorScheme.onSurface)
          else if (assetIcon != null)
            Image.asset(assetIcon!, width: 20, height: 20),
          if (icon != null || assetIcon != null) SizedBox(width: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
