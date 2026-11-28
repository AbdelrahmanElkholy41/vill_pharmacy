

import 'package:dio/dio.dart';

import '../../features/auth/data/datasource/auth_local_data_source.dart';

class DioClient {
  static const String baseUrl =
      'https://pharmacy-nu-ivory.vercel.app/api/v1';

  final AuthLocalDataSource localDataSource;

  late final Dio dio;
  late final Dio refreshDio;

  Future<String?>? _refreshFuture;

  DioClient(this.localDataSource) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    refreshDio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final path = options.path;

          final isAuthRequest =
              path.contains('/auth/login') ||
                  path.contains('/auth/register') ||
                  path.contains('/auth/refresh');

          if (!isAuthRequest) {
            final token = await localDataSource.getAccessToken();

            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }

          handler.next(options);
        },

        onError: (error, handler) async {
          final request = error.requestOptions;

          final isUnauthorized = error.response?.statusCode == 401;

          final alreadyRetried = request.extra['retried'] == true;

          final isRefreshRequest =
          request.path.contains('/auth/refresh');

          final isLoginRequest =
          request.path.contains('/auth/login');

          if (!isUnauthorized ||
              alreadyRetried ||
              isRefreshRequest ||
              isLoginRequest) {
            return handler.next(error);
          }

          try {
            final newAccessToken = await _refreshAccessToken();

            if (newAccessToken == null) {
              return handler.next(error);
            }

            request.headers['Authorization'] =
            'Bearer $newAccessToken';

            request.extra['retried'] = true;

            final response = await dio.fetch(request);

            return handler.resolve(response);
          } catch (_) {
            return handler.next(error);
          }
        },
      ),
    );
  }

  Future<String?> _refreshAccessToken() async {
    if (_refreshFuture != null) {
      return _refreshFuture!;
    }

    final future = _performRefresh();
    _refreshFuture = future;

    try {
      return await future;
    } finally {
      _refreshFuture = null;
    }
  }

  Future<String?> _performRefresh() async {
    final refreshToken = await localDataSource.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      return null;
    }

    try {
      final response = await refreshDio.post(
        '/auth/refresh',
        data: {
          'refreshToken': refreshToken,
        },
      );

      final data = response.data['data'];

      final newAccessToken = data['accessToken'] as String?;
      final newRefreshToken = data['refreshToken'] as String?;

      if (newAccessToken == null ||
          newRefreshToken == null ||
          newAccessToken.isEmpty ||
          newRefreshToken.isEmpty) {
        throw Exception('Invalid refresh response');
      }

      await localDataSource.saveAccessToken(newAccessToken);
      await localDataSource.saveRefreshToken(newRefreshToken);

      return newAccessToken;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;

      if (statusCode == 401 || statusCode == 403) {
        await localDataSource.clearTokens();
      }

      rethrow;
    }
  }
}
