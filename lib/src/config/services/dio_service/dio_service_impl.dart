import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_court/src/config/endpoints.dart';
import 'package:food_court/src/config/services/dio_service/dio_service.dart';

final Provider<DioServiceImpl> dioServiceImplProvider = Provider<DioServiceImpl>(
  (_) => DioServiceImpl()
);


class DioServiceImpl implements NetworkService {  
  
  DioServiceImpl() : _dio = Dio() {
    final BaseOptions baseOptions = BaseOptions(
      baseUrl: FCEndpoints.BASE_URL,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      contentType: 'application/json',
      validateStatus: _validateStatus,
    );

    _dio.options = baseOptions;

    _dio.interceptors.addAll(
      <Interceptor>[
        if (kDebugMode)
          LogInterceptor(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            error: true,
          ),
        // AddTokenInterceptor(_ref),
        // TokenRefreshInterceptor(_ref, _dio)
      ]
    );
  }

  final Dio _dio;

  @override
  Future<Response<dynamic>> get(
    String uri, 
    {Map<String, dynamic>? queryParameters}
  ) async => await _dio.get(uri, queryParameters: queryParameters);

  @override
  Future<Response<dynamic>> post(
    String uri, 
    {dynamic data, Map<String, dynamic>? queryParameters}
  ) async => await _dio.post(uri, data: data, queryParameters: queryParameters);

  @override
  Future<Response<dynamic>> patch(
    String uri, 
    {dynamic data, Map<String, dynamic>? queryParameters}
  ) async => await _dio.patch(uri, data: data, queryParameters: queryParameters);

  @override
  Future<Response<dynamic>> delete(
    String uri, 
    {dynamic data, Map<String, dynamic>? queryParameters}
  ) async => await _dio.delete(uri, data: data, queryParameters: queryParameters);

  @override
  Future<Response<dynamic>> put(
    String uri,
    {dynamic data, Map<String, dynamic>? queryParameters}
  ) async => await _dio.put(uri, data: data, queryParameters: queryParameters);

  @override
  Future<Response<dynamic>> formDataRequest(
    String uri, 
    {dynamic data, Map<String, dynamic>? queryParameters}
  ) async => await _dio.post(
    uri,
    data: FormData.fromMap(data),
    options: Options(contentType: 'multipart/form-data'),
  );

  @override
  Future<Response<dynamic>> patchFormDataRequest(
    String uri, 
    {dynamic data, Map<String, dynamic>? queryParameters}
  ) async => await _dio.patch(
    uri,
    data: FormData.fromMap(data),
    options: Options(contentType: 'multipart/form-data'),
  );


  bool _validateStatus(int? status) => status! == 200 || status == 201;
}

