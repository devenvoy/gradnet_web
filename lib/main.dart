import 'package:flutter/material.dart';
import 'package:gradnet_web/pages/new_password.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gradnet WebApp',
      theme: ThemeData(
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, fontFamily: 'Roboto'),
          headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Roboto'),
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
        ),
      ),
      home: const NewPasswordScreen(),
    );
  }
}
