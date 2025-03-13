import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/input_field.dart';
import '../widgets/primary_button.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  bool passwordVisible = false;
  bool confirmNewPasswordVisible = false;

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  void toggleConfirmPassword() {
    setState(() {
      confirmNewPasswordVisible = !confirmNewPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400), // Set max width
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
                      "Change Your Password",
                      style: heading2.copyWith(color: textBlack),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Enter a new password below to change your password",
                      style: regular16pt.copyWith(color: textGrey),
                    ),
                    const SizedBox(height: 24),
                    Form(
                      child: Column(
                        children: [
                          InputField(
                            obscureText: !passwordVisible,
                            hintText: 'New Password',
                            suffixIcon: IconButton(
                              color: textGrey,
                              splashRadius: 1,
                              icon: Icon(passwordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                              onPressed: togglePassword,
                            ),
                            controller: passwordController,
                          ),
                          const SizedBox(height: 16),
                          InputField(
                            obscureText: !confirmNewPasswordVisible,
                            hintText: 'Confirm New Password',
                            suffixIcon: IconButton(
                              color: textGrey,
                              splashRadius: 1,
                              icon: Icon(confirmNewPasswordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                              onPressed: toggleConfirmPassword,
                            ),
                            controller: confirmNewPasswordController,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomPrimaryButton(
                      buttonColor: primaryBlue,
                      textValue: 'Change Password',
                      textColor: Colors.white,
                      onPressed: () {},
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
