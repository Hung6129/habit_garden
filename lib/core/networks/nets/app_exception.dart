class AppException implements Exception {
  final int? code; // HTTP Status
  final String? message;
  final String? errorCode;
  final String? path;
  final dynamic detail;

  AppException(
      {required this.code,
      required this.message,
      this.errorCode,
      this.path,
      this.detail});
}

class FetchDataException extends AppException {
  FetchDataException({required super.message, required super.code});
}

class BadRequestException extends AppException {
  BadRequestException({
    required super.code,
    required super.message,
    required super.errorCode,
  });
}

class NotFoundException extends AppException {
  NotFoundException({
    required super.code,
    required super.message,
    required super.errorCode,
  });
}

class UnAuthorException extends AppException {
  UnAuthorException({required super.message, required super.code});
}

class InvalidInputException extends AppException {
  InvalidInputException({required super.message, required super.code})
      : super(errorCode: "invalid-input");
}

class AuthenticationException extends AppException {
  AuthenticationException({required super.message, required super.code})
      : super(errorCode: "authentication-failed");
}

class TimeOutException extends AppException {
  TimeOutException({required super.message, required super.code})
      : super(errorCode: 'request-timeout');
}

class NetworkException extends AppException {
  NetworkException({
    required super.code,
    required super.message,
    super.errorCode,
    super.path,
    super.detail,
  });
}

class LocalException extends AppException {
  LocalException({
    required super.code,
    required super.message,
    super.errorCode,
    super.path,
    super.detail,
  });
}

class ErrorCode {
  static const code9999 = 9999;
  static const String nongdanNetworkServiceError =
      'nongdan_network_service_error';
  static const duplicate = 'nong_dan_trung';
  static const fcDuplicate = 'nong_dan_fc_trung';
  static const sessionExpired = 'session_expired';
  static const wrongCurrentPassword = 'wrong_current_password';
  static const requestOtpLimited = 'otp_request_limit_exceeded';
  static const requestOtpExpired = 'otp_request_expired';
  static const invalidRequest = 'invalid_request';
  static const xncgOverLimitConfirm = 'vuot_khung_duyet_gia_xac_nhan_xncg';

  static const photoAccessDenied = 'photo_access_denied';
  static const cameraAccessDenied = 'camera_access_denied';
  static const invalidImage = 'invalid_image';
}
