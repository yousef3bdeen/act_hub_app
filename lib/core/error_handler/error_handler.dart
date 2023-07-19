import 'package:act_hub_app/config/constants.dart';
import 'package:act_hub_app/routes/routes.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../config/dependency_injection.dart';
import '../storage/local/app_settings_shared_preferences.dart';

class Failure {
  int code;
  String message;

  Failure(this.code, this.message);
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      final response = error.response;
      final statusCode = response?.statusCode ?? ResponseCode.BAD_REQUEST.value;
      final data = response?.data;

      if (response?.statusCode == ResponseCode.UNAUTHORIZED.value) {
        Future.delayed(
            const Duration(
              seconds: Constants.unauthenticatedSession,
            ), () {
          AppSettingsSharedPreferences appSettingsSharedPreferences =
              instance<AppSettingsSharedPreferences>();
          appSettingsSharedPreferences.clear();
          Get.offAllNamed(Routes.loginView);
        });
      }

      if (data != null) {
        final errorMessage = data[ApiConstants.message] ??
            data[ApiConstants.error]?[ApiConstants.message] ??
            data[ApiConstants.errors].values.first.first ??
            ApiConstants.error;

        failure = Failure(statusCode, errorMessage);
      } else {
        failure = Failure(statusCode, ApiConstants.error);
      }
    } else {
      failure = Failure(
        ResponseCode.BAD_REQUEST.value,
        ApiConstants.badRequest,
      );
    }
  }
}

enum ResponseCode {
  SUCCESS,
  CREATED,
  ACCEPTED,
  NO_CONTENT,
  BAD_REQUEST,
  UNAUTHORIZED,
  FORBIDDEN,
  NOT_FOUND,
  METHOD_NOT_ALLOWED,
  CONFLICT,
  INTERNAL_SERVER_ERROR,
  BAD_GATEWAY,
  SERVICE_UNAVAILABLE,
  GATEWAY_TIMEOUT,
  NO_INTERNET_CONNECTION,
  UNKNOWN;
}

extension ResponseCodeExtension on ResponseCode {
  int get value {
    switch (this) {
      case ResponseCode.SUCCESS:
        return 200;
      case ResponseCode.CREATED:
        return 201;
      case ResponseCode.ACCEPTED:
        return 202;
      case ResponseCode.NO_CONTENT:
        return 204;
      case ResponseCode.BAD_REQUEST:
        return 400;
      case ResponseCode.UNAUTHORIZED:
        return 401;
      case ResponseCode.FORBIDDEN:
        return 403;
      case ResponseCode.NOT_FOUND:
        return 404;
      case ResponseCode.METHOD_NOT_ALLOWED:
        return 405;
      case ResponseCode.CONFLICT:
        return 409;
      case ResponseCode.INTERNAL_SERVER_ERROR:
        return 500;
      case ResponseCode.BAD_GATEWAY:
        return 502;
      case ResponseCode.SERVICE_UNAVAILABLE:
        return 503;
      case ResponseCode.GATEWAY_TIMEOUT:
        return 504;
      case ResponseCode.NO_INTERNET_CONNECTION:
        return -1; // Or any appropriate value for "No Internet Connection"
      case ResponseCode.UNKNOWN:
        return -7;
    }
  }
}
