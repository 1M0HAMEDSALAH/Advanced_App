class BaseResponse<T> {
  final String? status;
  final String? message;
  final T data;

  BaseResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic data) fromJsonT,
  ) {
    return BaseResponse<T>(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: fromJsonT(json['data']),
    );
  }

  // New factory method for nested data structures
  factory BaseResponse.fromNestedJson(
    Map<String, dynamic> json,
    String dataKey,
    T Function(dynamic data) fromJsonT,
  ) {
    final nestedData = json['data']?[dataKey];
    return BaseResponse<T>(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: fromJsonT(nestedData),
    );
  }
}
