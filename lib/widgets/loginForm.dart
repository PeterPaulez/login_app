import 'package:api_login_app/models/authResponse.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:custom_route_transition_peterpaulez/custom_route_transition_peterpaulez.dart';

import 'package:api_login_app/services/authApi.dart';
import 'package:api_login_app/pages/home.dart';
import 'package:api_login_app/pages/register.dart';
import 'package:api_login_app/utils/dialog.dart';
import 'package:api_login_app/utils/responsive.dart';
import 'package:api_login_app/widgets/inputText.dart';

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
      print(response);

      if (response.statusCode == 200) {
        RouteTransitions(
          context: context,
          child: HomePage(),
          animation: AnimationType.slideLeft,
          duration: Duration(milliseconds: 1000),
          replacement: true,
          curveType: CurveType.bounce,
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
                      onPressed: () {},
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
                      RouteTransitions(
                        context: context,
                        child: RegisterPage(),
                        animation: AnimationType.slideLeft,
                        duration: Duration(milliseconds: 1000),
                        replacement: true,
                        curveType: CurveType.bounce,
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
              SizedBox(height: responsive.diagonalPercent(10)),
            ],
          ),
        ),
      ),
    );
  }
}
