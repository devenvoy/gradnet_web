import 'package:flutter/material.dart';

class FancyIndicator extends StatelessWidget {
  final Color color;

  const FancyIndicator({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
