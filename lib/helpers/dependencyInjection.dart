import 'package:api_login_app/services/auth.dart';
import 'package:get_it/get_it.dart';

abstract class DependencyInjection {
  static void initialize() {
    final AuthApi authApi = AuthApi();
    GetIt.instance.registerSingleton<AuthApi>(authApi);
  }
}
