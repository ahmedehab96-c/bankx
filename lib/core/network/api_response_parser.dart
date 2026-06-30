import 'package:dio/dio.dart';

/// Extracts the `data` envelope from standard BankX API responses.
abstract final class ApiResponseParser {
  static Map<String, dynamic> asMap(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      final data = responseData['data'];
      if (data is Map<String, dynamic>) return data;
      return responseData;
    }
    throw DioException(
      requestOptions: RequestOptions(),
      message: 'Invalid response format',
    );
  }

  static List<Map<String, dynamic>> asList(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      final data = responseData['data'];
      if (data is List) {
        return data.cast<Map<String, dynamic>>();
      }
    }
    if (responseData is List) {
      return responseData.cast<Map<String, dynamic>>();
    }
    throw DioException(
      requestOptions: RequestOptions(),
      message: 'Invalid list response format',
    );
  }
}
