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
      padding: EdgeInsets.only(left: 6, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(icon, size: 16, color: Theme.of(context).colorScheme.onSurface)
          else if (assetIcon != null)
            Image.asset(assetIcon!, width: 16, height: 16),
          if (icon != null || assetIcon != null) SizedBox(width: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
