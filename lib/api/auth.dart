import 'package:api_login_app/helpers/httpResponse.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart' show required;

class AuthApi {
  final Dio _dio = Dio();
  final Logger _logger = Logger();
  final String baseUrl = 'https://curso-api-flutter.herokuapp.com';

  Future<HttpResponse> register({
    @required String userName,
    @required String email,
    @required String password,
  }) async {
    try {
      // Simular más tiempo del real
      Future.delayed(Duration(seconds: 2));

      final response = await _dio.post<Map<String, dynamic>>(
        '$baseUrl/api/v1/register',
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
        data: {
          "username": userName,
          "email": email,
          "password": password,
        },
      );

      _logger.i(response.data);
      return HttpResponse.success(response.data);
    } catch (e) {
      _logger.e(e);
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
