import 'package:api_login_app/services/authApi.dart';
import 'package:api_login_app/services/authLocal.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

abstract class DependencyInjection {
  static void initialize() {
    final AuthApi authApi = AuthApi();
    GetIt.instance.registerSingleton<AuthApi>(authApi);

    final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
    final AuthLocal authLocal = AuthLocal(_secureStorage);
    GetIt.instance.registerSingleton<AuthLocal>(authLocal);
  }
}
