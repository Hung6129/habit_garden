// Base class for handling different types of results
import 'app_exception.dart';

class AppResult<BM> {
  // Private constructor to prevent direct instantiation
  AppResult._();

  // Factory constructor for a successful result
  factory AppResult.success(
    BM? netData,
  ) {
    return AppResultSuccess<BM>(netData: netData);
  }

  // Factory constructor for a failure result
  factory AppResult.failure(AppException? exception) {
    return AppResultFailure(exception: exception);
  }

  // Factory constructor for an empty result
  factory AppResult.exceptionEmpty() {
    return AppResultEmpty();
  }
}

// Class representing a successful result
class AppResultSuccess<BM> extends AppResult<BM> {
  AppResultSuccess({
    required this.netData,
  }) : super._();

  // The data returned from the network
  final BM? netData;
}

// Class representing a failure result
class AppResultFailure<BM> extends AppResult<BM> {
  AppResultFailure({required this.exception}) : super._();

  // The exception that occurred during the network request
  final AppException? exception;
}

// Class representing an empty result
class AppResultEmpty<BM> extends AppResult<BM> {
  AppResultEmpty() : super._();
}
