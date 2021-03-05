import 'package:api_login_app/helpers/httpResponse.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart' show required;

class Http {
  Dio _dio;
  Logger _logger;
  bool _logsEnabled;

  Http({
    @required Dio dio,
    @required Logger logger,
    @required bool logsEnabled,
  }) {
    _dio = dio;
    _logger = logger;
    _logsEnabled = logsEnabled;
  }

  Future<HttpResponse> request(
    String path, {
    String method = 'GET',
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> data,
    Map<String, String> headers,
  }) async {
    try {
      final response = await _dio.request<Map<String, dynamic>>(
        path,
        options: Options(
          method: method,
          headers: headers,
        ),
        queryParameters: queryParameters,
        data: data,
      );

      return HttpResponse.success(response.data);
    } catch (e) {
      int statusCode = -1;
      String message = 'unkown error';
      dynamic data;
      if (e is DioError) {
        message = e.message;
        if (e.response != null) {
          statusCode = e.response.statusCode;
          message = e.response.statusMessage;
          data = e.response.data;
        }
      }
      return HttpResponse.fail(
        statusCode: statusCode,
        message: message,
        data: data,
      );
    }
  }
}
