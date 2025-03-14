import 'package:flutter/material.dart';

class InterestTag extends StatelessWidget {
  final String text;
  final VoidCallback? onClick;
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final BorderRadius borderRadius;

  const InterestTag({
    super.key,
    required this.text,
    this.onClick,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
          borderRadius: borderRadius,
        ),
        child: Text(
          text,
          style: textStyle ??
              Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textColor ?? Theme.of(context).colorScheme.onSurface,
                  ),
        ),
      ),
    );
  }
}
