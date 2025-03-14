import 'package:flutter/material.dart';
import 'package:gradnet_web/projects/routes/app_route_config.dart';
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
    final myRouter = MyAppRouter(); // Create router instance once

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ForgotPasswordProvider()),
      ],

      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,

        title: 'Gradnet WebApp',

        theme: ThemeData(
          textTheme: TextTheme(
            headlineLarge: heading2,
            headlineSmall: heading5,
            bodyLarge: regular16pt,
          ),
        ),

        routeInformationParser: myRouter.router.routeInformationParser,

        routerDelegate: myRouter.router.routerDelegate,
      ),
    );
  }
}
