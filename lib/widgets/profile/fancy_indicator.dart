import 'package:flutter/material.dart';

class FancyIndicator extends Decoration {
  final Color color;

  const FancyIndicator({required this.color});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _FancyIndicatorPainter(color);
  }
}

class _FancyIndicatorPainter extends BoxPainter {
  final Color color;

  _FancyIndicatorPainter(this.color);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final rect = Offset(offset.dx, configuration.size!.height - 4) &
        Size(configuration.size!.width, 4);
    final rRect = RRect.fromRectAndRadius(rect, Radius.circular(5.0));

    canvas.drawRRect(rRect, paint);
  }
}