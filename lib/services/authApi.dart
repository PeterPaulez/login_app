import 'package:api_login_app/models/authResponse.dart';
import 'package:flutter/material.dart' show required;
import 'package:dio/dio.dart';

class AuthApi {
  Future<AuthResponse> register({
    @required String userName,
    @required String email,
    @required String password,
  }) {
    return request(
      '/api/v1/register',
      method: 'POST',
      data: {
        "username": userName,
        "email": email,
        "password": password,
      },
    );
  }

  Future<AuthResponse> login({
    @required String email,
    @required String password,
  }) {
    return request(
      '/api/v1/login',
      method: 'POST',
      data: {
        "email": email,
        "password": password,
      },
    );
  }

  Future<AuthResponse> refreshToken(String expiredToken) {
    return request(
      '/api/v1/refresh-token',
      method: 'POST',
      headers: {
        "token": expiredToken,
      },
    );
  }

  Future<AuthResponse> request(
    String path, {
    String method = 'GET',
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> data,
    Map<String, String> headers,
  }) async {
    final Dio _dio = Dio(
      BaseOptions(baseUrl: 'https://curso-api-flutter.herokuapp.com'),
    );
    try {
      final response = await _dio.request(
        path,
        options: Options(
          method: method,
          headers: headers,
        ),
        queryParameters: queryParameters,
        data: data,
      );

      final AuthResponse authResponse = AuthResponse.fromJson({
        'token': response.data['token'],
        'expiresIn': response.data['expiresIn'],
        'statusCode': response.statusCode,
      });
      return authResponse;
    } catch (e) {
      int statusCode = -1;
      String message = 'unkown error';
      List duplicatedFields;
      print(e.response.data);
      if (e is DioError) {
        message = e.message;
        if (e.response != null) {
          statusCode = e.response.statusCode;
          message = e.response.statusMessage;
          duplicatedFields = e.response.data['duplicatedFields'];
        }
      }

      final AuthResponse authResponse = AuthResponse.fromJson({
        'message': message,
        'duplicatedFields': duplicatedFields,
        'statusCode': statusCode,
      });

      return authResponse;
    }
  }
}
