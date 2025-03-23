import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../model/post_model.dart';

class PostProvider extends ChangeNotifier {
  String? postId;
  Post? post;
  bool isLoading = false;
  String? errorMessage;
  final Dio _dio = Dio(); // Use a single Dio instance

  void setPostId(String id) {
    if (postId != id) {
      postId = id;
      post = null; // Clear old data when a new postId is set
    }
  }

  Future<void> fetchPostDetails() async {
    if (postId == null || isLoading) return;

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      var response = await _dio.get(
        "https://grednet-production.up.railway.app/post/web/$postId",
      );

      if (response.statusCode == 200 && response.data["status"]) {
        post = Post.fromJson(response.data["data"]);
      } else {
        errorMessage = "Failed to load post details.";
      }
    } catch (e) {
      errorMessage = "Error fetching post details: $e";
      log("Error fetching post details: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
