import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gradnet_web/projects/routes/app_route_constants.dart';

import '../theme.dart';
import '../widgets/input_field.dart';
import '../widgets/primary_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userIdController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 5,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome to Graduate Network",
                      style: heading2.copyWith(color: textBlack),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Enter a userId below to See details",
                      style: regular16pt.copyWith(color: textGrey),
                    ),
                    const SizedBox(height: 24),
                    Form(
                      child: Column(
                        children: [
                          InputField(
                            hintText: 'Enter user id',
                            controller: userIdController,
                            suffixIcon: IconButton(
                              color: textGrey,
                              splashRadius: 1,
                              icon: Icon(Icons.person),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomPrimaryButton(
                      buttonColor: primaryBlue,
                      textValue: 'Show User Posts',
                      textColor: Colors.white,
                      showLoader: false,
                      onPressed: () {
                        String userId = userIdController.text;
                        if (userId.isNotEmpty) {
                          GoRouter.of(context).pushNamed(
                            MyAppRouteConstants.postRouteName,
                            params: {'userId': userId},
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 14),
                    CustomPrimaryButton(
                      buttonColor: primaryBlue,
                      textValue: 'Show User Profile',
                      textColor: Colors.white,
                      showLoader: false,
                      onPressed: () {
                        String userId = userIdController.text;
                        if (userId.isNotEmpty) {
                          GoRouter.of(context).pushNamed(
                            MyAppRouteConstants.profileRouteName,
                            params: {'userId': userId},
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
