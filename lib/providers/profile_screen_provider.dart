import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:gradnet_web/model/profile_model.dart';

class ProfileScreenProvider extends ChangeNotifier {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://grednet-production.up.railway.app',
      headers: {'accept': 'application/json'},
    ),
  );

  Future<UserProfileResponse> getUserProfile(String userId) async {
    try {
      final response = await _dio.get('/fetch_profile/$userId');
      log("TAG111 Response: ${response.data}");

      if (response.statusCode == 200 && response.data['status'] == true) {
        UserProfileResponse result = UserProfileResponse.fromJson(response.data['data']);
        log("TAG111 Parsed UserProfileResponse: $result");
        return result;
      } else {
        log('Error: ${response.statusMessage}');
        throw Exception('Failed to fetch user profile');
      }
    } catch (e) {
      log('Exception: $e');
      throw Exception('Error fetching user profile');
    }
  }

}
