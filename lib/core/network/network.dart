import 'package:dio/dio.dart';

class AppNetwork {
  final Dio _dio;

  AppNetwork(this._dio) {
    _dio.interceptors.addAll([
      _requestInterceptor(),
      _errorInterceptor(),
    ]);
  }

  InterceptorsWrapper _requestInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        return handler.next(options);
      },
    );
  }

  InterceptorsWrapper _errorInterceptor() {
    return InterceptorsWrapper(onError: (e, handler) async {
      return handler.next(e);
    });
  }

  Future<Response> _create(
    String url, {
    required String method,
    data,
    headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? extra,
  }) async {
    try {
      final res = await _dio.request(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          method: method,
          headers: headers,
          extra: extra,
        ),
      );
      return res;
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response?.data;
        throw (data['message']);
      }

      throw ("Something went wrong");
    }
  }

  Future<Response> get(
    String url, {
    dynamic headers,
    dynamic query,
  }) async {
    final res = await _create(
      url,
      method: "GET",
      headers: headers,
      queryParameters: query,
    );
    return res;
  }

  Future<Response> post(
    String url, {
    dynamic headers,
    dynamic data,
  }) async {
    final res = await _create(
      url,
      method: "POST",
      headers: headers,
      data: data,
    );
    return res;
  }
}
