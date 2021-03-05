import 'package:api_login_app/api/auth.dart';
import 'package:api_login_app/helpers/http.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

abstract class DependencyInjection {
  static void initialize() {
    final Dio dio = Dio(
      BaseOptions(baseUrl: 'https://curso-api-flutter.herokuapp.com'),
    );
    final Logger logger = Logger();
    Http _http = Http(
      dio: dio,
      logger: logger,
      logsEnabled: true,
    );
    final AuthApi authApi = AuthApi(_http);
    GetIt.instance.registerSingleton<AuthApi>(authApi);
  }
}
