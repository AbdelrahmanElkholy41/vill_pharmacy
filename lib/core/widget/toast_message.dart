import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

enum ToastType {
  success,
  error,
  warning,
}

class AppToast {
  static void show(
    BuildContext context, {
    required String message,
    ToastType type = ToastType.success,
    Duration duration = const Duration(seconds: 3),
  }) {
    final messenger = ScaffoldMessenger.of(context);

    final Color backgroundColor;
    final Color accentColor;
    final IconData icon;

    switch (type) {
      case ToastType.success:
        backgroundColor = const Color(0xFFDCFCE7);
        accentColor = const Color(0xFF16A34A);
        icon = Iconsax.tick_circle;
        break;

      case ToastType.error:
        backgroundColor = const Color(0xFFFEE2E2);
        accentColor = const Color(0xFFDC2626);
        icon = Iconsax.warning_2;
        break;

      case ToastType.warning:
        backgroundColor = const Color(0xFFFEF3C7);
        accentColor = const Color(0xFFD97706);
        icon = Iconsax.info_circle;
        break;
    }

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                icon,
                color: accentColor,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Color(0xFF27272A),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          duration: duration,
          dismissDirection: DismissDirection.horizontal,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      );
  }

  static void showError(
    BuildContext context,
    Object error,
  ) {
    final message = getErrorMessage(error);

    show(
      context,
      message: message,
      type: ToastType.error,
      duration: const Duration(seconds: 4),
    );
  }

  static String getErrorMessage(Object error) {
    if (error is DioException) {
      final response = error.response;
      final data = response?.data;

      if (data is Map) {
        final backendMessage = data['message'];

        if (backendMessage is String && backendMessage.trim().isNotEmpty) {
          return backendMessage;
        }

        if (backendMessage is List && backendMessage.isNotEmpty) {
          return backendMessage.map((item) => item.toString()).join('\n');
        }
      }

      if (response == null) {
        switch (error.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
            return 'انتهت مهلة الاتصال، حاول مرة أخرى';

          case DioExceptionType.connectionError:
            return 'تعذر الاتصال بالسيرفر، تأكد من الإنترنت';

          case DioExceptionType.badCertificate:
            return 'تعذر تأمين الاتصال بالسيرفر';

          default:
            return 'تعذر الاتصال بالسيرفر، حاول مرة أخرى';
        }
      }

      return 'حدث خطأ أثناء تنفيذ الطلب (${response.statusCode})';
    }

// لو الخطأ Exception عادي
    if (error is Exception) {
      final message = error.toString().replaceFirst('Exception: ', '').trim();

      if (message.isNotEmpty) {
        return message;
      }
    }

    return 'حدث خطأ غير متوقع، حاول مرة أخرى';
  }

  static void showSuccess(
    BuildContext context,
    String message,
  ) {
    show(
      context,
      message: message,
      type: ToastType.success,
    );
  }

  /// رسالة تحذير
  static void showWarning(
    BuildContext context,
    String message,
  ) {
    show(
      context,
      message: message,
      type: ToastType.warning,
    );
  }
}
