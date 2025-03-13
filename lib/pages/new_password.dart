import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme.dart';
import '../widgets/input_field.dart';
import '../widgets/primary_button.dart';
import '../providers/forgot_password_provider.dart'; 

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final forgotPasswordProvider = context.watch<ForgotPasswordProvider>();

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
                            obscureText: !forgotPasswordProvider.passwordVisible,
                            hintText: 'New Password',
                            errorText: forgotPasswordProvider.passwordError,
                            suffixIcon: IconButton(
                              color: textGrey,
                              splashRadius: 1,
                              icon: Icon(forgotPasswordProvider.passwordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                              onPressed: forgotPasswordProvider.togglePassword,
                            ),
                            controller: forgotPasswordProvider.passwordController,
                          ),
                          const SizedBox(height: 16),
                          InputField(
                            obscureText:
                                !forgotPasswordProvider.confirmNewPasswordVisible,
                            hintText: 'Confirm New Password',
                            errorText: forgotPasswordProvider.confirmPasswordError,
                            suffixIcon: IconButton(
                              color: textGrey,
                              splashRadius: 1,
                              icon: Icon(
                                  forgotPasswordProvider.confirmNewPasswordVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined),
                              onPressed:
                                  forgotPasswordProvider.toggleConfirmPassword,
                            ),
                            controller:
                                forgotPasswordProvider.confirmNewPasswordController,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomPrimaryButton(
                      buttonColor: primaryBlue,
                      textValue: 'Change Password',
                      textColor: Colors.white,
                      onPressed: forgotPasswordProvider.validateAndSubmit,
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
