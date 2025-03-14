import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gradnet_web/model/api_response.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordProvider extends ChangeNotifier {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  bool passwordVisible = false;
  bool confirmNewPasswordVisible = false;

  String? passwordError;
  String? confirmPasswordError;
  bool isLoading = false;

  void togglePassword() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  void toggleConfirmPassword() {
    confirmNewPasswordVisible = !confirmNewPasswordVisible;
    notifyListeners();
  }

  Future<String?> validateAndSubmit(String oldPassword, String token) async {
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
      return await _changePassword(oldPassword, password, token);
    }
    return null;
  }

  Future<String> _changePassword(
    String oldPassword,
    String newPassword,
    String token,
  ) async {
    isLoading = true;
    notifyListeners();

    const String url =
        'https://grednet-production.up.railway.app/change-password/';

    try {
      log("TAG111: Started");
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "old_password": oldPassword,
          "new_password": newPassword,
        }),
      );
      log("TAG111: still going");

      // Ensure response body is properly parsed
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      log("TAG111: response came $jsonResponse");

      stopLoader();

      final apiResponse = ApiResponse.fromJson(jsonResponse);

      return apiResponse.detail.message;
    } catch (e) {
      stopLoader();
      log("TAG111: error $e");
      return "Failed to change password. Please try again.";
    }
  }

  void stopLoader() {
    isLoading = false;
    notifyListeners();
  }
}
