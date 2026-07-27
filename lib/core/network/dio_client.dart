import 'package:dio/dio.dart';

/// Cliente HTTP centralizado.
///
/// Beneficios de tenerlo en un solo lugar:
/// - Un único `baseUrl`, timeouts e interceptores para toda la app.
/// - Fácil de mockear en tests (se inyecta el `Dio` o esta clase).
class DioClient {
  DioClient({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
                headers: {'Accept': 'application/json'},
              ),
            ) {
    // Interceptor de logging solo en modo debug (ver core/utils/app_logger.dart)
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          // TODO: enviar a un servicio de crash reporting (ver Fase 4 del PLAN.md)
          handler.next(error);
        },
      ),
    );
  }

  final Dio _dio;

  Dio get instance => _dio;
}
