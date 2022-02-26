import 'package:dio/dio.dart';
import 'package:efficacy_admin/constant/constant.dart';

class NetworkEngine {
  late Dio _dio;

  NetworkEngine() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseurl,
        connectTimeout: 45,
        receiveTimeout: 60,
      ),
    );
    initializeInterceptor();
  }

  Future<Response> post(
      {required Map<String, dynamic> data, required String endPoint}) async {
    Response response;
    try {
      response = await _dio.post(endPoint, data: data);
      return response;
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
  }

  Future<Response> get({required String endPoint}) async {
    Response response;
    try {
      response = await _dio.get(endPoint);
      return response;
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
  }

  initializeInterceptor() {
    _dio.interceptors
        .add(InterceptorsWrapper(onError: (error, errorInterceptorHandler) {
      print(error.message);
    }, onRequest: (request, requestInterceptorHandler) {
      print("${request.method} | ${request.path}");
    }, onResponse: (response, responseInterceptorHandler) {
      print('${response.statusCode} ${response.statusCode} ${response.data}');
    }));
  }
}
