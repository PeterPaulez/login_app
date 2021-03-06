import 'package:api_login_app/api/auth.dart';
import 'package:get_it/get_it.dart';

abstract class DependencyInjection {
  static void initialize() {
    final AuthApi authApi = AuthApi();
    GetIt.instance.registerSingleton<AuthApi>(authApi);
  }
}
