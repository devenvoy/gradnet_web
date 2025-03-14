import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String resultMessage;

  const ResultScreen({super.key, required this.resultMessage});



  @override
  Widget build(BuildContext context) {
    // Retrieve the result message from the arguments

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
