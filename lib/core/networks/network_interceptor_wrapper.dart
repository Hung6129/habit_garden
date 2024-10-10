part of 'network_service.dart';

class NetworkInterceptorWrapper extends QueuedInterceptorsWrapper {
  late final Dio diO;

  final _logger = Logger(printer: PrettyPrinter(methodCount: 0));

  NetworkInterceptorWrapper({required this.diO});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final header = await _headerToken();
    options.headers.addAll(header);
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    _logger.e('Response: DioError: ${err.response?.data}');
    // // Go Next when call api login || refreshToken
    // if (err.requestOptions.path.contains('api/login')) {
    //   return handler.next(err);
    // }
    // // Do something with response error
    // if (err.response?.statusCode == 401 &&
    //     err.response?.data['meta']['errorMessages'] == 'jwt expired') {
    //   // Handle refresh token
    //   _logger
    //       .e('Token expired: ${err.response?.data['meta']['errorMessages']}');
    //   final refreshToken =
    //       Global.storageServices.getString(AppStorage.refreshToken);
    //   if (refreshToken.isNotEmpty) {
    //     final response = await diO.post(
    //       AppUrls.refreshToken,
    //       data: {'refresh_token': refreshToken},
    //       options: Options(
    //         headers: _basicToken,
    //       ),
    //     );
    //     if (response.statusCode == 200) {
    //       final token = response.data['token'];
    //       Global.storageServices.setString(AppStorage.userTokenKey, token);
    //       return handler.resolve(await diO.fetch(err.requestOptions));
    //     }
    //   }
    //   Get.find<AppService>().forceLogout();
    // } else {
    //   return handler.next(err);
    // }
  }

  Future<Map<String, String>> _headerToken() async {
    // final token = Global.storageServices.getString(AppStorage.userTokenKey);
    const token = '';
    final tokenHeader =
        token.isEmpty ? _basicToken : {'Authorization': 'Bearer $token'};
    return {
      ...tokenHeader,
    };
  }

  Map<String, String> get _basicToken => {
        'Authorization': 'Basic mobile:mobile',
      };
}
