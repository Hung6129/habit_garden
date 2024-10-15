import 'dart:io';
import 'package:dio/dio.dart';
import 'package:habit_garden/core/data/local/app_pref_key.dart';
import 'package:habit_garden/core/data/local/app_shared_pref.dart';
import 'package:habit_garden/core/networks/api_provider.dart';
import 'package:habit_garden/core/services/app_services.dart';
import 'package:habit_garden/core/services/injection_service.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'client_request.dart';
import 'nets/app_exception.dart';
import 'nets/app_response.dart';
import 'nets/app_result.dart';

part 'network_interceptor_wrapper.dart';

abstract class NetworkService {
  static const requestTimeOut = Duration(seconds: 120);

  static Dio newDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiProvider.baseUrl,
        connectTimeout: requestTimeOut,
        receiveTimeout: requestTimeOut,
      ),
    )..interceptors.add(
        PrettyDioLogger(
          request: true,
          requestBody: true,
          responseBody: true,
          error: true,
          compact: true,
        ),
      );

    return dio;
  }

  Future<AppResult<AppResponse>> request(
      {required ClientRequest clientRequest});
}

class NetworkServiceImpl extends NetworkService {
  late final Dio _dio;
  final Logger _logger = Logger(printer: PrettyPrinter(methodCount: 0));

  // NetworkServiceImpl() {
  //   _dio = NetworkService.newDio();
  //   _dio.interceptors.add(NetworkInterceptorWrapper(diO: _dio));
  // }

  NetworkServiceImpl():super(){
    _dio = NetworkService.newDio();
    _dio.interceptors.add(NetworkInterceptorWrapper(diO: _dio));
  }

  @override
  Future<AppResult<AppResponse>> request({
    required ClientRequest clientRequest,
  }) async {
    try {
      final response = await _dio.request(
        clientRequest.url,
        data: clientRequest.body,
        options: Options(
          method: clientRequest.method.value,
          contentType: clientRequest.contentType,
          headers: {...clientRequest.headers ?? {}},
          receiveTimeout: NetworkService.requestTimeOut,
        ),
        queryParameters: clientRequest.query,
        onSendProgress: clientRequest.onSendProgress,
        onReceiveProgress: clientRequest.onReceiveProgress,
      );
      final AppResponse appResponse = clientRequest.isRequestForList
          ? AppResponse.fromJsonToList(response.data)
          : AppResponse.fromJson(response.data);
      return
          // HttpStatus.ok = 200 and HttpStatus.created = 201,
          // depending on the request usually 201 is for created POST request
          // you can add more status code if you want
          response.statusCode == HttpStatus.ok ||
                  response.statusCode == HttpStatus.created
              ? AppResult.success(appResponse)
              : AppResult.failure(
                  NetworkException(
                    code: response.statusCode,
                    message: appResponse.meta?.message,
                    errorCode: appResponse.meta?.errorMessages,
                  ),
                );
    } on DioException catch (e) {
      _logger.e('Response: DioError: ${e.response?.data}');
      Metadata? meta = AppResponse.fromJson(e.response?.data).meta;
      return AppResult.failure(
        NetworkException(
          code: e.response?.statusCode,
          message: meta?.message,
          errorCode: meta?.errorMessages ?? 'network_service',
        ),
      );
    } catch (e) {
      _logger.e('Some things wrong: ${e.toString()}');
      return AppResult.failure(
        NetworkException(
          code: 999999,
          message: 'SomeThingsWrong: ${e.toString()}',
          errorCode: 'network_service',
        ),
      );
    }
  }
}
