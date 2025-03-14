import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gradnet_web/pages/home_page.dart';
import 'package:gradnet_web/pages/new_password.dart';
import 'package:gradnet_web/pages/password_result.dart';
import 'package:gradnet_web/pages/post_page.dart';
import 'package:gradnet_web/pages/profile_page.dart';
import 'package:gradnet_web/projects/routes/app_route_constants.dart';

class MyAppRouter {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: MyAppRouteConstants.homeRouteName,
        path: '/',
        pageBuilder: (context, state) {
          return MaterialPage(child: HomeScreen());
        },
      ),

      GoRoute(
        name: MyAppRouteConstants.newPasswordRouteName,
        path: '/${MyAppRouteConstants.newPasswordRouteName}',
        pageBuilder: (context, state) {
          final token = state.queryParams["token"];

          if (token == null || token.isEmpty) {
            return MaterialPage(
              child: ResultScreen(resultMessage: "Invalid or missing token"),
            );
          }

          return MaterialPage(child: NewPasswordScreen(token: token));
        },
      ),

      GoRoute(
        name: MyAppRouteConstants.postRouteName,
        path: '/${MyAppRouteConstants.postRouteName}/:userId',
        pageBuilder: (context, state) {
          return MaterialPage(child: PostPage(
            userId: state.params["userId"]!,
          ));
        },
      ),

      GoRoute(
        name: MyAppRouteConstants.profileRouteName,
        path: '/${MyAppRouteConstants.profileRouteName}/:userId',
        pageBuilder: (context, state) {
          return MaterialPage(child: ProfileScreen(
            userId: state.params["userId"]!,
          ));
        },
      ),

      GoRoute(
        name: MyAppRouteConstants.resultRouteName,
        path: '/${MyAppRouteConstants.resultRouteName}',
        pageBuilder: (context, state) {
          final message =
              state.queryParams["message"] ?? "Invalid or missing token";
          return MaterialPage(child: ResultScreen(resultMessage: message));
        },
      ),

      // GoRoute(
      //   name: MyAppRouteConstants.profileRouteName,
      //   path: '/profile/:userid',
      //   pageBuilder: (context, state) {
      //     return MaterialPage(
      //         child: Profile(
      //       userid: state.params['userid']!,
      //     ));
      //   },
      // ),
    ],
    errorPageBuilder: (context, state) {
      return NoTransitionPage(
        child: ResultScreen(resultMessage: "404 Page Not Found"),
      );
    },
    debugLogDiagnostics: true,
  );
}
