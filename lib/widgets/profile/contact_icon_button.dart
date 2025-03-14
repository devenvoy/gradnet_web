import 'package:flutter/material.dart';

class ContactIconButton extends StatelessWidget {
  final IconData icon;
  final String? contentDescription;
  final VoidCallback onClick;

  const ContactIconButton({
    super.key,
    required this.icon,
    this.contentDescription,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(21), // Half of 42.dp
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Center(
          child: Icon(
            icon,
            size: 24,
          ),
        ),
      ),
    );
  }
}
