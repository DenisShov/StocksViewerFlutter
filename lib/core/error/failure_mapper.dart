import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'failure.dart';

/// The data-layer component converting transport exceptions into
/// [Failure] values.
///
/// This file is a plain Dart class: it imports `dio` and `dart:io` but not
/// Flutter, so it stays usable from the data layer without dragging in the
/// framework.
class FailureMapper {
  const FailureMapper();

  /// Converts a caught exception into a [Failure].
  ///
  /// A [DioException] is classified by its [DioExceptionType]; any other
  /// object, including [ParseException], `CheckedFromJsonException`,
  /// [FormatException], and `ApiKeyMissingException`, becomes a
  /// [GeneralFailure].
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

  /// Converts a 2xx response whose body is absent, null, or empty into a
  /// [ServerFailure], for repositories/data sources to call explicitly
  /// since Dio itself does not throw on that condition.
  Failure fromEmptySuccessBody(int statusCode) {
    return ServerFailure(statusCode: statusCode, message: 'Response body is null');
  }

  /// Resolves the [ServerFailure] message for a non-2xx response.
  ///
  /// Prefers a non-blank `error` string field from a JSON body, falling
  /// back to the response's status message, and finally the empty string.
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
      } catch (_) {
        // Not parseable as JSON; fall through to the status message.
      }
    }

    return response?.statusMessage ?? '';
  }

  /// Returns the `error` field of [data] when it is a string with at
  /// least one non-whitespace character, otherwise `null`.
  String? _nonBlankErrorField(Map data) {
    final errorValue = data['error'];
    if (errorValue is String && errorValue.trim().isNotEmpty) {
      return errorValue;
    }
    return null;
  }
}
