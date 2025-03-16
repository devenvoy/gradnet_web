import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../model/post_model.dart';

class PostProvider extends ChangeNotifier {
  String? postId;
  Post? post;
  bool isLoading = true;

  void setPostId(String id) {
    postId = id;
  }

  Future<void> fetchPostDetails() async {
    if (postId == null) return;
    isLoading = true;
    notifyListeners();
    try {
      var response = await Dio().get("https://grednet-production.up.railway.app/post/$postId");
      if (response.statusCode == 200 && response.data["status"]) {
        post = Post.fromJson(response.data["data"]);
      }
    } catch (e) {
      log("Error fetching post details: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}