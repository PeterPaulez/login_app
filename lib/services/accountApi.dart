import 'package:api_login_app/models/user.dart';
import 'package:api_login_app/services/authLocal.dart';
import 'package:dio/dio.dart';

class AccountApi {
  final AuthLocal _authLocal;

  AccountApi(this._authLocal);

  Future<User> getUserInfo() async {
    final token = await _authLocal.accesToken;
    return request(
      '/api/v1/user-info',
      method: 'GET',
      headers: {
        "token": token,
      },
    );
  }

  Future<User> request(
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

      final User userResponse = User(
        id: response.data['_id'],
        username: response.data['username'],
        email: response.data['email'],
        createdAt: DateTime.parse(response.data['createdAt']),
        updatedAt: DateTime.parse(response.data['updatedAt']),
      );
      return userResponse;
    } catch (e) {
      print(e);
      final User userResponse = User(
        id: null,
        username: null,
        email: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      return userResponse;
    }
  }
}
