import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gradnet_web/projects/routes/app_route_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Welcome to GradNet", style: TextStyle(fontSize: 18)),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).pushNamed(
                  MyAppRouteConstants.newPasswordRouteName,
                  queryParams: {'token': 'jnonovnadonv'},
                );
              },
              child: Text("new password"),
            ),
          ],
        ),
      ),
    );
  }
}
