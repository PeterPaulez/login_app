import 'package:api_login_app/models/user.dart';
import 'package:api_login_app/pages/login.dart';
import 'package:api_login_app/services/accountApi.dart';
import 'package:api_login_app/services/authLocal.dart';
import 'package:transitioner/transitioner.dart';
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
    String tokenMini = widget.token;
    if (tokenMini.length > 35) {
      tokenMini = '${tokenMini.substring(0, 35)}...';
    }
    final TextStyle textStyleTitle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.pinkAccent,
    );

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.all(7),
          child: CircleAvatar(
            child: Text('Me',
                style: TextStyle(fontSize: 16, color: Colors.pinkAccent)),
            backgroundColor: Colors.white,
            maxRadius: 14,
          ),
        ),
        title: Column(
          children: [
            Text('Home Page', style: TextStyle(fontSize: 20)),
            Text('User logged', style: TextStyle(fontSize: 10)),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: _signOut,
            child: Icon(Icons.logout, color: Colors.white),
          ),
        ],
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_user == null) CircularProgressIndicator(),
            if (_user != null)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Token: ', style: textStyleTitle),
                      Text(tokenMini),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('UserId: ', style: textStyleTitle),
                      Text(_user.id),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Email: ', style: textStyleTitle),
                      Text(_user.email),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('UserName: ', style: textStyleTitle),
                      Text(_user.username),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    await _authLocal.signOut();
    Transitioner(
      context: context,
      child: LoginPage(),
      animation: AnimationType.slideBottom,
      duration: Duration(milliseconds: 2000),
      replacement: true,
      curveType: CurveType.bounce,
    );
  }
}
