import 'package:flutter/material.dart';
import 'package:gradnet_web/pages/new_password.dart';
import 'package:gradnet_web/pages/password_result.dart';
import 'package:gradnet_web/providers/forgot_password_provider.dart';
import 'package:gradnet_web/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ForgotPasswordProvider()),
      ],
      child: MaterialApp(
        routes: {'/passwordResult': (context) => PasswordResultScreen()},
        debugShowCheckedModeBanner: false,
        title: 'Gradnet WebApp',
        theme: ThemeData(
          textTheme: TextTheme(
            headlineLarge: heading2,
            headlineSmall: heading5,
            bodyLarge: regular16pt,
          ),
        ),
        home: NewPasswordScreen(),
      ),
    );
  }
}
