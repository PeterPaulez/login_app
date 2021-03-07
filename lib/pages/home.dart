import 'package:api_login_app/models/user.dart';
import 'package:api_login_app/pages/login.dart';
import 'package:api_login_app/services/accountApi.dart';
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
  final AccountApi _accountApi = GetIt.instance<AccountApi>();
  User _user;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUser();
    });
  }

  Future<void> _loadUser() async {
    final response = await _accountApi.getUserInfo();
    print(response);
    if (response.username != null) {
      print(response.username);
      _user = response;
      setState(() {});
    } else {
      _signOut();
    }
  }

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Home Page\nToken: ${widget.token}',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 10),
            if (_user == null) CircularProgressIndicator(),
            if (_user != null)
              Column(
                children: [
                  Text('ID: ${_user.id}'),
                  Text('EMAIL: ${_user.email}'),
                  Text('NAME: ${_user.username}'),
                ],
              ),
          ],
        ),
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
