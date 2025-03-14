class Post {
  final String postId;
  final String userId;
  final String userName;
  final String userProfilePic;
  final String description;
  final String location;
  final List<String> photos;
  final String createdAt;
  final int likes;
  final bool isLiked;
  final String userRole;

  Post({
    required this.postId,
    required this.userId,
    required this.userName,
    required this.userProfilePic,
    required this.description,
    required this.location,
    required this.photos,
    required this.createdAt,
    required this.likes,
    required this.isLiked,
    required this.userRole,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json["post_id"] ?? "",  // Ensuring empty string if null
      userId: json["user_id"] ?? "",
      userName: json["user_name"] ?? "",
      userProfilePic: json["user_profile_pic"] ?? "",  // Empty string instead of null
      description: json["description"] ?? "",
      location: json["location"] ?? "",
      photos: List<String>.from(json["photos"] ?? []),
      createdAt: json["created_at"]?.toString() ?? "",  // Ensuring it's a String
      likes: json["likes"] ?? 0,
      isLiked: json["liked_by"] ?? false,  // Ensuring it's a boolean
      userRole: json["user_role"] ?? "",
    );
  }
}
