// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class AddTokenInterceptor extends Interceptor {
//   final Ref _ref;

//   AddTokenInterceptor(this._ref);
//   int count = 0;

//   @override
//   Future<void> onRequest(options, handler) async {
//     if (_skipAuthorization(options.path)) {
//       return handler.next(options);
//     }

//     final String? accessToken = await _ref.read(storageProvider).get(CSIStrings.ACCESS_TOKEN);
//     if(accessToken == null){
//       return handler.reject(
//         DioException(
//           requestOptions: options,
//           type: DioExceptionType.cancel,
//           message: CSIStrings.SESSION_EXPIRED,
//         ),
//       );
//     }
    
//     options.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';

//     handler.next(options);
//   }

//   bool _skipAuthorization(String path) {
//     final authPaths = [
//       '/login', '/register', '/resend-otp'
//       '/refresh-token', '/reset-password',
//       '/verify-otp', '/forgot-password'
//     ];
//     return authPaths.any((p) => path.contains(p));
//   }
// }



// class TokenRefreshInterceptor extends Interceptor {
//   final Ref ref;
//   final Dio dio;
//   bool _isRefreshing = false;
//   final _requestQueue = Queue<Completer>();

//   TokenRefreshInterceptor(this.ref, this.dio);
//   @override
//   Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
//     final statusCode = err.response?.statusCode;
//     final requestOptions = err.requestOptions;

//     if (statusCode != 401 || requestOptions.path.contains('/auth/refresh')) {
//       return handler.next(err);
//     }

//     if (_isRefreshing) {
//       final completer = Completer();
//       _requestQueue.add(completer);
//       await completer.future;
//       return _retryRequest(requestOptions, handler);
//     }

//     _isRefreshing = true;

//     try {
//       final refreshToken = await ref.read(storageProvider).get(CSIStrings.REFRESH_TOKEN);
//       log(refreshToken.toString());
//       if (refreshToken == null) {        
//         return handler.next(err);
//       }

//       final newAccessToken = await _refreshToken(refreshToken);
//       if (newAccessToken == null) {
//         return handler.next(err);
//       }

//       _processQueue();
//       return _retryRequest(requestOptions, handler);
//     } catch (e) {
//       handler.next(err);
//     } finally {
//       _isRefreshing = false;
//     }
//   }


//   Future<void> _retryRequest(
//     RequestOptions requestOptions,
//     ErrorInterceptorHandler handler,
//   ) async {
//     try {
//       final newToken = await ref.read(storageProvider).get(CSIStrings.ACCESS_TOKEN);

//       final options = Options(
//         method: requestOptions.method,
//         headers: {
//           ...requestOptions.headers,
//           'Authorization': 'Bearer $newToken',
//         },
//       );

//       final response = await dio.request(
//         requestOptions.path,
//         data: requestOptions.data,
//         queryParameters: requestOptions.queryParameters,
//         options: options,
//       );

//       handler.resolve(response);
//     } catch (e) {
//       handler.next(
//         DioException(requestOptions: requestOptions, error: e),
//       );
//     }
//   }

//   Future<String?> _refreshToken(String refreshToken) async {
//     try {
//       final response = await dio.post(
//         CSIEndpoints.BASE_URL + CSIEndpoints.REFRESH_TOKEN,
//         data: {'refreshToken': refreshToken},
//       );

//       final newAccessToken = response.data['data']['access_token'] as String?;

//       await ref.read(storageProvider).set(
//         CSIStrings.ACCESS_TOKEN, newAccessToken
//       );

//       return newAccessToken;
//     } catch (e) {
//       log('Token refresh failed: $e');
//       return null;
//     }
//   }

//   void _processQueue() {
//     while (_requestQueue.isNotEmpty) {
//       log('requestQueue is not Empty');
//       _requestQueue.removeFirst().complete();
//     }
//   }
// }
