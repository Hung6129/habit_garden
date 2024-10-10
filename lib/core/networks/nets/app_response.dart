class AppResponse {
  final Metadata? meta;
  final dynamic data;
  final int totalPage;
  final int pageNum;
  final int totalResult;
  final int limit;

  AppResponse({
    this.meta,
    this.data,
    this.totalPage = 0,
    this.pageNum = 1,
    this.totalResult = 0,
    this.limit = 10,
  });

  factory AppResponse.fromJson(Map<String, dynamic>? json) {
    return AppResponse(
      meta: Metadata.fromJson(json?['meta']),
      data: json?['result'],
    );
  }

  static AppResponse fromJsonToList(Map<String, dynamic>? json) {
    return AppResponse(
      meta: Metadata.fromJson(json?['meta']),
      data: json?['result'],
      totalPage: json?['totalPage'],
      pageNum: json?['pageNum'],
      totalResult: json?['totalResult'],
      limit: json?['limit'],
    );
  }
}

class Metadata {
  final int statusCode;
  final String? errorMessages;
  final String? message;

  Metadata({
    required this.statusCode,
    this.errorMessages,
    this.message,
  });

  factory Metadata.fromJson(Map<String, dynamic>? json) => Metadata(
        statusCode: json?['statusCode'] ?? 0,
        errorMessages: json?['errorMessages'] ?? '',
        message: json?['message'] ?? '',
      );
}
