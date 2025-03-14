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
                  MyAppRouteConstants.postRouteName,
                  params: {'userId':'75ed0707-e5e7-45cf-9013-c6cbe79ceb49'}
                );
              },
              child: Text("post page"),
            ),
          ],
        ),
      ),
    );
  }
}
