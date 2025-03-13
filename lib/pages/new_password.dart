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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Set New Password on Your\nEmail",
                      style: heading2.copyWith(color: textBlack),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/images/accent.png',
                      width: 99,
                      height: 4,
                    )
                  ],
                ),
                SizedBox(
                  height: 48,
                ),
                Form(
                  child: Column(
                    children: [
                      InputField(
                        obscureText: passwordVisible,
                          hintText: 'New Password',
                          suffixIcon: IconButton(
                            color: textGrey,
                            splashRadius: 1,
                            icon: Icon(passwordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                            onPressed: togglePassword,
                          ),
                          controller: passwordController),
                      SizedBox(
                        height: 24,
                      ),
                      InputField(
                        obscureText: confirmNewPasswordVisible,
                          hintText: 'Confirm New Password',
                          suffixIcon: IconButton(
                            color: textGrey,
                            splashRadius: 1,
                            icon: Icon(confirmNewPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                            onPressed: toggleConfirmPassword,
                          ),
                          controller: confirmNewPasswordController),
                    ],
                  ),
                ),
                SizedBox(
                  height: 48,
                ),
                CustomPrimaryButton(
                    buttonColor: primaryBlue,
                    textValue: 'Update Password',
                    textColor: Colors.white,
                    onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
