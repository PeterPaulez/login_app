import 'package:api_login_app/pages/home.dart';
import 'package:api_login_app/pages/login.dart';
import 'package:api_login_app/services/authLocal.dart';
import 'package:transitioner/transitioner.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthLocal _authLocal = GetIt.instance<AuthLocal>();
  @override
  void initState() {
    super.initState();
    // Esto hace que no haya ninguna vista no renderizada
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLogin();
    });
  }

  Future<void> _checkLogin() async {
    final String token = await _authLocal.accesToken;
    if (token == null) {
      Transitioner(
        context: context,
        child: LoginPage(),
        animation: AnimationType.slideTop,
        duration: Duration(milliseconds: 2000),
        replacement: true,
        curveType: CurveType.bounce,
      );
      return;
    }
    Transitioner(
      context: context,
      child: HomePage(token: token),
      animation: AnimationType.slideTop,
      duration: Duration(milliseconds: 2000),
      replacement: true,
      curveType: CurveType.bounce,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
