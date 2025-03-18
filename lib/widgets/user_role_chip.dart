import 'package:flutter/material.dart';

class UserRoleChip extends StatelessWidget {
  final String userRole;

  const UserRoleChip({super.key, required this.userRole});

  Color getRoleColor(String role) {
    switch (role) {
      case 'ALUMNI':
        return Color(0xFF4CAF50);
      case 'FACULTY':
        return Color(0xFF2196F3);
      case 'ORGANIZATION':
        return Color(0xFFFFC107);
      case 'ADMIN':
        return Color(0xFFF44336);
      default:
        return Color(0xFFF44336);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getRoleColor(userRole),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Text(
        userRole[0].toUpperCase() + userRole.substring(1).toLowerCase(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
