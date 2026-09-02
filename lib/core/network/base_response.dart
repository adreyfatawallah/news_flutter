class BaseResponse<T> {
  final String status;
  final int totalResults;
  final T? data;

  BaseResponse({
    required this.status,
    required this.totalResults,
    required this.data,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return BaseResponse(
      status: json['status'],
      totalResults: json['totalResults'],
      data: json['articles'] != null ? fromJsonT(json['articles']) : null,
    );
  }
}
