import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'failure.dart';

class FailureMapper {
  const FailureMapper();

  Failure fromException(Object error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.badResponse:
          final response = error.response;
          final statusCode = response?.statusCode ?? 0;
          final message = _extractErrorMessage(response);
          return ServerFailure(statusCode: statusCode, message: message);

        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const NetworkFailure();

        case DioExceptionType.connectionError:
          if (error.error is SocketException) {
            return const NetworkFailure();
          }
          return const GeneralFailure();

        case DioExceptionType.cancel:
        case DioExceptionType.badCertificate:
        case DioExceptionType.unknown:
        default:
          return const GeneralFailure();
      }
    }
    return const GeneralFailure();
  }

  Failure fromEmptySuccessBody(int statusCode) {
    return ServerFailure(
      statusCode: statusCode,
      message: 'Response body is null',
    );
  }

  String _extractErrorMessage(Response<dynamic>? response) {
    final data = response?.data;

    if (data is Map) {
      final fromMap = _nonBlankErrorField(data);
      if (fromMap != null) return fromMap;
    } else if (data is String) {
      try {
        final decoded = jsonDecode(data);
        if (decoded is Map) {
          final fromJson = _nonBlankErrorField(decoded);
          if (fromJson != null) return fromJson;
        }
      } catch (_) {}
    }

    return response?.statusMessage ?? '';
  }

  String? _nonBlankErrorField(Map data) {
    final errorValue = data['error'];
    if (errorValue is String && errorValue.trim().isNotEmpty) {
      return errorValue;
    }
    return null;
  }
}
