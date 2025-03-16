import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  bool passwordVisible = false;
  bool confirmNewPasswordVisible = false;

  String? passwordError;
  String? confirmPasswordError;
  bool isLoading = false;
  final Dio _dio = Dio();

  void togglePassword() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  void toggleConfirmPassword() {
    confirmNewPasswordVisible = !confirmNewPasswordVisible;
    notifyListeners();
  }

  Future<String?> validateAndSubmit(String token) async {
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
      return await _changePassword(password, token);
    }
    return null;
  }

  Future<String> _changePassword(String newPassword, String token) async {
    isLoading = true;
    notifyListeners();

    final String url =
        'https://grednet-production.up.railway.app/auth/reset-password/$token';

    final FormData formData = FormData.fromMap({
      "new_password": newPassword,
      "re_new_password": newPassword,
    });

    log("Sending request to $url with data: ${formData.fields}");

    try {
      final response = await _dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            'accept': 'application/json',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      stopLoader();

      log("Response: ${response.data}");

      if (response.statusCode == 200 && response.data['status'] == true) {
        return response.data['message'] ?? "Password changed successfully";
      } else {
        return response.data['message'] ??
            "Failed to change password. Please try again.";
      }
    } catch (e) {
      stopLoader();

      if (e is DioException) {
        log("Error Response Data: ${e.response?.data}");
        return e.response?.data['detail']?.toString() ??
            "Failed to change password. Please try again.";
      }

      log("Unknown error: $e");
      return "An unexpected error occurred.";
    }
  }

  void stopLoader() {
    isLoading = false;
    notifyListeners();
  }
}
