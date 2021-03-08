import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:api_login_app/models/authResponse.dart';
import 'package:api_login_app/models/session.dart';
import 'package:api_login_app/services/authApi.dart';
import 'package:api_login_app/utils/logs.dart';

class AuthLocal {
  final AuthApi _authApi;
  Completer _completer;
  AuthLocal(this._authApi);

  Future<String> get accesToken async {
    if (_completer != null) {
      await _completer.future;
    }
    _completer = Completer();

    void _complete() {
      if (_completer != null && !_completer.isCompleted) {
        _completer.complete();
      }
    }

    SharedPreferences pref = await SharedPreferences.getInstance();
    final data = pref.get('SESSION');
    if (data != null) {
      final session = Session.fromJson(jsonDecode(data));

      // Vamos a comprobar el tiempo de vida del token
      final DateTime currentDate = DateTime.now();
      final diff = currentDate.difference(session.createdAt).inSeconds;
      final int timing = session.expiresIn - diff;

      if (timing >= 60) {
        Logs.insta.i('Refreshed time: $timing');

        _complete();
        return session.token;
      }

      final AuthResponse response = await _authApi.refreshToken(session.token);
      if (response.token != null) {
        Logs.insta.i('Old token: ${session.token}');
        Logs.insta.i('Refreshed token: $response');
        await this.saveSession(response);

        _complete();
        return response.token;
      }

      _complete();
      return null;
    }

    _complete();
    return null;
  }

  Future<void> saveSession(AuthResponse authResponse) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final Session session = Session(
      token: authResponse.token,
      expiresIn: authResponse.expiresIn,
      createdAt: DateTime.now(),
    );
    final data = jsonEncode(session.toJson());
    await pref.setString('SESSION', data);
  }

  Future<void> signOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('SESSION');
  }
}
