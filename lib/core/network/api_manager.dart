import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/prefrences/PrefsHandler.dart';
import 'package:ecommerce_app/core/resources/constants_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
@singleton
class ApiManager {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      validateStatus: (status) => status! < 500,
    ));

    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
    ));

    // ✅ Interceptor لإضافة التوكن تلقائيًا
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
    final token = PrefsHandler.getToken();
    print('Token in interceptor: $token');
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    // أضف هذه الهيدرات الإضافية
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';
    options.headers['X-Requested-With'] = 'XMLHttpRequest';
    return handler.next(options);
  },
    ));
  }

  Future<Response> GetRequest(String endpoint,
      {Map<String, dynamic>? parameters, Map<String, dynamic>? headers}) {
    return dio.get(
      endpoint,
      queryParameters: parameters,
      options: Options(headers: headers),
    );
  }

  Future<Response> PostRequestRawData(String endpoint,
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) {
    return dio.post(
      endpoint,
      data: body,
      options: Options(headers: headers),
    );
  }

  Future<Response> PostRequestFormData(String endpoint,
      Map<String, dynamic> body,
      {Map<String, dynamic>? headers}) {
    return dio.post(
      endpoint,
      data: FormData.fromMap(body),
      options: Options(headers: headers),
    );
  }
  Future<Response> DeleteRequest(String endpoint,
    {Map<String, dynamic>? headers}) {
  return dio.delete(
    endpoint,
    options: Options(headers: headers),
  );
}

}
