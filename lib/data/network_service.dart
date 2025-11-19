import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:sfm_logistic/core/auth_interceptor.dart';
import 'package:sfm_logistic/data/models/data_result.dart';
import 'package:sfm_logistic/services/token_storage_service.dart';

class NetworkService {
  final Dio dio;

  NetworkService(TokenStorageService storage)
    : dio = Dio(
        BaseOptions(
          baseUrl: 'http://80.253.246.63:5000/',

          // Timeout'lar artırıldı - Mobil ağ için
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 15),

          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },

          // Her istekte yeni bağlantı - Stale connection sorununu önler
          persistentConnection: false,
        ),
      ) {
    // HTTP Adapter - Connection pool ayarları
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 15);
      client.idleTimeout = const Duration(seconds: 3);
      // Connection pool'u minimize et - Stale connection önleme
      client.maxConnectionsPerHost = 1;
      return client;
    };

    // Auth interceptor
    dio.interceptors.add(AuthInterceptor(storage));

    // Retry interceptor - Otomatik yeniden deneme
    dio.interceptors.add(_createRetryInterceptor());

    // Logging interceptor
    dio.interceptors.add(_createLoggingInterceptor());
  }

  InterceptorsWrapper _createRetryInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) async {
        // Sadece network hatalarında retry yap
        if (_shouldRetry(error)) {
          final retryCount = error.requestOptions.extra['retryCount'] ?? 0;

          if (retryCount < 3) {
            log(
              '[RETRY] Deneme ${retryCount + 1}/3 - ${error.requestOptions.path}',
            );

            // Exponential backoff: 1s, 2s, 3s
            await Future.delayed(Duration(seconds: retryCount + 1));

            error.requestOptions.extra['retryCount'] = retryCount + 1;

            try {
              final response = await dio.fetch(error.requestOptions);
              return handler.resolve(response);
            } catch (e) {
              // Retry de başarısız, normal error handling'e devam et
              log('[RETRY] Başarısız - ${retryCount + 1}/3');
            }
          } else {
            log('[RETRY] Maximum deneme sayısına ulaşıldı');
          }
        }

        return handler.next(error);
      },
    );
  }

  InterceptorsWrapper _createLoggingInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        log('[HTTP] ${options.method} ${options.path}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        log('[HTTP] ✅ ${response.statusCode} ${response.requestOptions.path}');
        return handler.next(response);
      },
      onError: (error, handler) {
        log('[HTTP] ❌ ${error.type} - ${error.message}');
        return handler.next(error);
      },
    );
  }

  bool _shouldRetry(DioException error) {
    // Sadece network/timeout hatalarında retry yap
    // Auth hataları (401) vs. için retry yapma
    return (error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.receiveTimeout ||
            error.type == DioExceptionType.sendTimeout ||
            error.type == DioExceptionType.connectionError ||
            (error.type == DioExceptionType.unknown &&
                error.message?.toLowerCase().contains('socket') == true)) &&
        error.response?.statusCode != 401 && // Auth hatası değilse
        error.response?.statusCode != 403; // Forbidden değilse
  }

  Future<DataResult<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic data)? parser,
  }) async {
    log('path:$path');
    try {
      final response = await dio.get(path, queryParameters: queryParameters);

      return Success(parser != null ? parser(response.data) : response.data);
    } on DioException catch (e) {
      return Failure<T>(_handleDioError(e));
    } catch (e) {
      return Failure<T>("Bilinmeyen hata: $e");
    }
  }

  Future<DataResult<T>> post<T>(
    String path, {
    dynamic body,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final response = await dio.post(path, data: body);
      return Success(parser != null ? parser(response.data) : response.data);
    } on DioException catch (e) {
      return Failure<T>(_handleDioError(e));
    } catch (e) {
      return Failure<T>("Bilinmeyen hata: $e");
    }
  }

  Future<DataResult<T>> put<T>(
    String path, {
    dynamic body,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final response = await dio.put(path, data: body);
      return Success(parser != null ? parser(response.data) : response.data);
    } on DioException catch (e) {
      return Failure<T>(_handleDioError(e));
    } catch (e) {
      return Failure<T>("Bilinmeyen hata: $e");
    }
  }

  Future<DataResult<T>> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final response = await dio.delete(path, queryParameters: queryParameters);
      return Success(parser != null ? parser(response.data) : response.data);
    } on DioException catch (e) {
      return Failure<T>(_handleDioError(e));
    } catch (e) {
      return Failure<T>("Bilinmeyen hata: $e");
    }
  }

  String _handleDioError(DioException e) {
    // Response varsa (sunucuya ulaştı ama hata döndü)
    if (e.response != null) {
      final statusCode = e.response?.statusCode;

      if (statusCode == 401) {
        return "Oturum süreniz dolmuş. Lütfen tekrar giriş yapın.";
      } else if (statusCode == 403) {
        return "Bu işlem için yetkiniz yok.";
      } else if (statusCode == 404) {
        return "İstenen kaynak bulunamadı.";
      } else if (statusCode == 500) {
        return "Sunucu hatası. Lütfen daha sonra tekrar deneyin.";
      } else {
        return "Sunucu hatası: ${e.response?.statusCode} ${e.response?.statusMessage}";
      }
    }

    // Network/timeout hataları
    if (e.type == DioExceptionType.connectionTimeout) {
      return "Bağlantı zaman aşımına uğradı. İnternet bağlantınızı kontrol edin.";
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return "Sunucu yanıt vermedi. Lütfen tekrar deneyin.";
    } else if (e.type == DioExceptionType.sendTimeout) {
      return "İstek gönderilemedi. İnternet bağlantınızı kontrol edin.";
    } else if (e.type == DioExceptionType.connectionError) {
      return "Sunucuya bağlanılamıyor. İnternet bağlantınızı kontrol edin.";
    } else if (e.type == DioExceptionType.badCertificate) {
      return "Sertifika hatası";
    } else {
      // Unknown error - Detaylı mesaj
      final message = e.message ?? '';
      if (message.toLowerCase().contains('socket')) {
        return "Bağlantı hatası. Lütfen internet bağlantınızı kontrol edin.";
      }
      return "Ağ hatası: ${e.message}";
    }
  }
}
