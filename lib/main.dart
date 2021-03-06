import 'package:api_login_app/helpers/dependencyInjection.dart';
import 'package:api_login_app/pages/home.dart';
import 'package:api_login_app/pages/login.dart';
import 'package:api_login_app/pages/register.dart';
import 'package:api_login_app/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // Injection de dependencias
  DependencyInjection.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Api Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
      routes: {
        RegisterPage.routeName: (_) => RegisterPage(),
        LoginPage.routeName: (_) => LoginPage(),
        HomePage.routeName: (_) => HomePage(),
      },
    );
  }
}
