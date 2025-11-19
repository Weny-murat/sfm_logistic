import 'package:dio/dio.dart';
import 'package:sfm_logistic/services/token_storage_service.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorageService storage;

  AuthInterceptor(this.storage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await storage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }
}
