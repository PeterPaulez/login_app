import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart' show required;

class AuthApi {
  final Dio _dio = Dio();
  final Logger _logger = Logger();
  final String baseUrl = 'https://curso-api-flutter.herokuapp.com';

  Future<void> register({
    @required String userName,
    @required String email,
    @required String password,
  }) async {
    try {
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
    } catch (e) {
      _logger.e(e);
    }
  }
}
