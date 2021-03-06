import 'dart:convert';

import 'package:api_login_app/models/authResponse.dart';
import 'package:api_login_app/models/session.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocal {
  final FlutterSecureStorage _secureStorage;
  AuthLocal(this._secureStorage);

  Future<String> get accesToken async {
    final data = await this._secureStorage.read(key: 'SESSION');
    if (data != null) {
      final session = Session.fromJson(jsonDecode(data));
      return session.token;
    }
    return null;
  }

  Future<void> saveSession(AuthResponse authResponse) async {
    final Session session = Session(
      token: authResponse.token,
      expiresIn: authResponse.expiresIn,
      createdAt: DateTime.now(),
    );
    final data = jsonEncode(session.toJson());
    await this._secureStorage.write(key: 'SESSION', value: data);
  }

  Future<void> signOut() async {
    await this._secureStorage.deleteAll();
  }
}
