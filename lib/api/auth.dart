import 'package:api_login_app/helpers/http.dart';
import 'package:api_login_app/helpers/httpResponse.dart';
import 'package:flutter/material.dart' show required;

class AuthApi {
  final Http _http;
  AuthApi(this._http);

  Future<HttpResponse> register({
    @required String userName,
    @required String email,
    @required String password,
  }) {
    return _http.request(
      '/api/v1/register',
      method: 'POST',
      data: {
        "username": userName,
        "email": email,
        "password": password,
      },
    );
  }

  Future<HttpResponse> login({
    @required String email,
    @required String password,
  }) {
    return _http.request(
      '/api/v1/login',
      method: 'POST',
      data: {
        "email": email,
        "password": password,
      },
    );
  }
}
