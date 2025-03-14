import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gradnet_web/model/post_model.dart';

class PostScreenProvider extends ChangeNotifier {
  List<Post> _posts = [];
  bool _isLoading = false;
  final Dio _dio = Dio();
  String _message = ""; // Message for UI feedback

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  String get message => _message;

  Future<void> fetchUserPosts(String userId) async {
    _isLoading = true;
    _message = ""; // Reset message
    _posts.clear(); // Clear old posts
    notifyListeners();

    try {
      Response response = await _dio.get(
        'https://grednet-production.up.railway.app/posts/user',
        queryParameters: {'user_id': userId},
        options: Options(headers: {'accept': 'application/json'}),
      );

      if (response.statusCode == 200 && response.data['status'] == true) {
        List<dynamic> postsJson = response.data['data'];
        _posts = postsJson.map((json) => Post.fromJson(json)).toList().reversed.toList();
        _message = _posts.isEmpty ? "No posts available" : "";
      } else {
        _message = response.data['message'] ?? "Invalid user ID or no posts found";
      }
    } catch (e) {
      _message = "Error fetching posts";
      log('TAG111: Error fetching posts: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _posts.clear();
    _message = ""; // Reset message on dispose
    super.dispose();
  }
}
