import 'package:api_login_app/helpers/http.dart';
import 'package:api_login_app/helpers/httpResponse.dart';
import 'package:api_login_app/models/authResponse.dart';
import 'package:flutter/material.dart' show required;

class AuthApi {
  final Http _http;
  AuthApi(this._http);

  Future<HttpResponse<AuthResponse>> register({
    @required String userName,
    @required String email,
    @required String password,
  }) {
    return _http.request<AuthResponse>(
      '/api/v1/register',
      method: 'POST',
      data: {
        "username": userName,
        "email": email,
        "password": password,
      },
      parser: (data) {
        return AuthResponse.fromJson(data);
      },
    );
  }

  Future<HttpResponse<AuthResponse>> login({
    @required String email,
    @required String password,
  }) {
    return _http.request<AuthResponse>(
      '/api/v1/login',
      method: 'POST',
      data: {
        "email": email,
        "password": password,
      },
      parser: (data) {
        return AuthResponse.fromJson(data);
      },
    );
  }
}
