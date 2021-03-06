import 'package:api_login_app/pages/login.dart';
import 'package:api_login_app/services/authLocal.dart';
import 'package:custom_route_transition_peterpaulez/custom_route_transition_peterpaulez.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home';
  final String token;
  HomePage({Key key, this.token}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthLocal _authLocal = GetIt.instance<AuthLocal>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          MaterialButton(
            onPressed: _signOut,
            child: Icon(Icons.logout),
          ),
        ],
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Text('Home Page\nToken: ${widget.token}'),
      ),
    );
  }

  Future<void> _signOut() async {
    await _authLocal.signOut();
    RouteTransitions(
      context: context,
      child: LoginPage(),
      animation: AnimationType.slideBottom,
      duration: Duration(milliseconds: 2000),
      replacement: true,
      curveType: CurveType.bounce,
    );
  }
}
