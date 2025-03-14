
class ApiResponse {
  final Detail detail;

  ApiResponse({required this.detail});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      detail: Detail.fromJson(json["detail"]),
    );
  }
}

class Detail {
  final bool status;
  final int code;
  final String message;
  final Map<String, dynamic> data;

  Detail({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      status: json["status"] ?? false,
      code: json["code"] ?? 0,
      message: json["message"] ?? "Unknown error",
      data: json["data"] ?? {},
    );
  }
}
