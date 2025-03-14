import 'package:flutter/material.dart';

class PasswordResultScreen extends StatelessWidget {
  const PasswordResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the result message from the arguments
    final String resultMessage =
        ModalRoute.of(context)?.settings.arguments as String? ?? "No result";

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            resultMessage,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
