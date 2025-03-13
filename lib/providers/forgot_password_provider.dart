import 'dart:developer';
import 'package:flutter/material.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  bool passwordVisible = false;
  bool confirmNewPasswordVisible = false;

  String? passwordError;
  String? confirmPasswordError;

  void togglePassword() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  void toggleConfirmPassword() {
    confirmNewPasswordVisible = !confirmNewPasswordVisible;
    notifyListeners();
  }

  void validateAndSubmit() {
    String password = passwordController.text.trim();
    String confirmPassword = confirmNewPasswordController.text.trim();

    if (password.isEmpty) {
      passwordError = "Password cannot be empty";
    } else {
      passwordError = null;
    }

    if (confirmPassword.isEmpty) {
      confirmPasswordError = "Confirm password cannot be empty";
    } else if (password != confirmPassword) {
      confirmPasswordError = "Passwords do not match";
    } else {
      confirmPasswordError = null;
    }

    notifyListeners();

    if (passwordError == null && confirmPasswordError == null) {
      log("Password changed successfully");
    }
  }
}
