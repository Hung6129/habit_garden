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
    // Go Next when call api login || refreshToken
    if (err.requestOptions.path.contains('api/login')) {
      return handler.next(err);
    }
    // Do something with response error
    if (err.response?.data['meta']['errorMessages'] == 'jwt expired') {
      _logger
          .e('Token expired: ${err.response?.data['meta']['errorMessages']}');
      // Handle refresh token
      final refreshToken =
          await iS<AppSharedPref>().getValue(AppPrefKey.refreshToken, '');
      _logger.d('Get old Refresh token: $refreshToken');
      if (refreshToken.isNotEmpty) {
        final response = await diO.post(
          ApiProvider.refreshToken,
          data: {
            'refreshToken': refreshToken,
          },
          options: Options(
            headers: _basicToken,
          ),
        );
        if (response.statusCode == 200) {
          final newToken = response.data['result']['newAccessToken'];
          final newRefreshToken = response.data['result']['newRefreshToken'];
          _logger.d(
              'Get new Token: $newToken and new Refresh token: $newRefreshToken');
          await iS<AppSharedPref>().setValue(AppPrefKey.token, newToken);
          await iS<AppSharedPref>()
              .setValue(AppPrefKey.refreshToken, newRefreshToken);
          return handler.resolve(await diO.fetch(err.requestOptions));
        }
      }
      // Force logout
      iS<AppServices>().forceLogout();
    } else {
      // iS<AppServices>().forceLogout();
      return handler.next(err);
    }
  }

  Future<Map<String, String>> _headerToken() async {
    final token = await iS<AppSharedPref>().getValue(AppPrefKey.token, '');
    // _logger.d('Header token: $token');
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
