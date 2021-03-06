import 'package:api_login_app/pages/init.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:transitioner/transitioner.dart';

import 'package:api_login_app/services/authLocal.dart';
import 'package:api_login_app/services/authApi.dart';
import 'package:api_login_app/utils/responsive.dart';
import 'package:api_login_app/utils/dialog.dart';
import 'package:api_login_app/utils/logs.dart';
import 'package:api_login_app/pages/register.dart';
import 'package:api_login_app/pages/home.dart';
import 'package:api_login_app/widgets/inputText.dart';
import 'package:api_login_app/models/authResponse.dart';

class LoginFormWidget extends StatefulWidget {
  LoginFormWidget({Key key}) : super(key: key);

  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '', _password = '';

  Future<void> _submit() async {
    final isOk = _formKey.currentState.validate();
    print("isok => $isOk");
    print("email => $_email");
    print("password => $_password");
    if (isOk) {
      ProgressDialog.show(context);
      final _authApi = GetIt.instance<AuthApi>();
      final AuthResponse response = await _authApi.login(
        email: _email,
        password: _password,
      );
      ProgressDialog.dissmiss(context);
      Logs.insta.i(response);

      if (response.statusCode == 200) {
        final _authLocal = GetIt.instance<AuthLocal>();
        await _authLocal.saveSession(response);
        Transitioner(
          context: context,
          child: HomePage(token: response.token),
          animation: AnimationType.slideLeft,
          duration: Duration(milliseconds: 2000),
          replacement: true,
          curveType: CurveType.bounceOut,
        );
      } else {
        String message = response.message;
        if (response.statusCode == -1) {
          message = 'Bad Network';
        } else if (response.statusCode == 403) {
          message = 'Invalid password';
        } else if (response.statusCode == 404) {
          message = 'Invalid email';
        }
        TextDialog.alert(
          context,
          title: 'Error',
          content: message,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTablet ? 430 : 360,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              InputTextWidget(
                labelText: 'EMAIL ADDRESS',
                keyboardType: TextInputType.emailAddress,
                fontSize: responsive.diagonalPercent(1.4),
                onChanged: (text) => _email = text,
                validator: (text) {
                  if (!text.contains("@") ||
                      text == null ||
                      text.trim().length < 5) {
                    return 'Invalid E-mail';
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.diagonalPercent(2)),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black12),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InputTextWidget(
                        labelText: 'PASSWORD',
                        obscureText: true,
                        borderEnabled: false,
                        fontSize: responsive.diagonalPercent(1.4),
                        onChanged: (text) => _password = text,
                        validator: (text) {
                          if (text == null || text.trim().length < 4) {
                            return 'Invalid Password (Minimum 4 chars)';
                          }
                          return null;
                        },
                      ),
                    ),
                    MaterialButton(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      onPressed: () {
                        Transitioner(
                          context: context,
                          child: InitPage(),
                          animation: AnimationType.slideLeft,
                          duration: Duration(milliseconds: 2000),
                          replacement: true,
                          curveType: CurveType.elastic,
                        );
                      },
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: responsive.diagonalPercent(1.5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: responsive.diagonalPercent(5)),
              MaterialButton(
                padding: EdgeInsets.symmetric(
                    vertical: responsive.diagonalPercent(1.5)),
                minWidth: double.infinity,
                onPressed: this._submit,
                child: Text(
                  'Sign in',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.diagonalPercent(1.5)),
                ),
                color: Colors.pinkAccent,
              ),
              SizedBox(height: responsive.diagonalPercent(2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Are you new here?',
                    style: TextStyle(
                      fontSize: responsive.diagonalPercent(1.5),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Transitioner(
                        context: context,
                        child: RegisterPage(),
                        animation: AnimationType.slideLeft,
                        duration: Duration(milliseconds: 2000),
                        replacement: true,
                        curveType: CurveType.linear,
                      );
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: responsive.diagonalPercent(1.5),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: responsive.diagonalPercent(5)),
            ],
          ),
        ),
      ),
    );
  }
}
