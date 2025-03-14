import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class RichTextView extends StatelessWidget {
  final String text;

  const RichTextView({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: text,
      softLineBreak: true,
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
        p: const TextStyle(fontSize: 14.0),
      ),
    );
  }
}
