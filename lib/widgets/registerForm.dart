import 'package:api_login_app/api/auth.dart';
import 'package:api_login_app/helpers/httpResponse.dart';
import 'package:api_login_app/pages/login.dart';
import 'package:api_login_app/utils/dialog.dart';
import 'package:api_login_app/utils/responsive.dart';
import 'package:api_login_app/widgets/inputText.dart';
import 'package:custom_route_transition_peterpaulez/custom_route_transition_peterpaulez.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class RegisterFormWidget extends StatefulWidget {
  RegisterFormWidget({Key key}) : super(key: key);

  @override
  _RegisterFormWidgetState createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email, _password, _userName = '';
  Logger _logger = Logger();

  Future<void> _submit() async {
    final isOk = _formKey.currentState.validate();
    print("isok => $isOk");
    print("email => $_email");
    print("password => $_password");
    print("userName => $_userName");
    if (isOk) {
      ProgressDialog.show(context);
      final AuthApi _authApi = AuthApi();
      final HttpResponse response = await _authApi.register(
        userName: _userName,
        email: _email,
        password: _password,
      );
      ProgressDialog.dissmiss(context);

      if (response.data != null) {
        _logger.i('Registro OK ${response.data}');
      } else {
        _logger.e('Registro KO ${response.error.statusCode}');
        _logger.e('Registro KO ${response.error.message}');
        _logger.e('Registro KO ${response.error.data}');
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
                labelText: 'USERNAME',
                fontSize: responsive.diagonalPercent(1.4),
                onChanged: (text) => _userName = text,
                validator: (text) {
                  if (text == null || text.trim().length < 4) {
                    return 'Invalid username (min 4 chars)';
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.diagonalPercent(2)),
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
              InputTextWidget(
                labelText: 'PASSWORD',
                obscureText: true,
                fontSize: responsive.diagonalPercent(1.4),
                onChanged: (text) => _password = text,
                validator: (text) {
                  if (text == null || text.trim().length < 6) {
                    return 'Invalid password (min 6 chars)';
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.diagonalPercent(5)),
              MaterialButton(
                padding: EdgeInsets.symmetric(
                    vertical: responsive.diagonalPercent(1.5)),
                minWidth: double.infinity,
                onPressed: this._submit,
                child: Text(
                  'Sign up',
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
                    'Already have an account?',
                    style: TextStyle(
                      fontSize: responsive.diagonalPercent(1.5),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      RouteTransitions(
                        context: context,
                        child: LoginPage(),
                        animation: AnimationType.slideRight,
                        duration: Duration(milliseconds: 1000),
                        replacement: true,
                        curveType: CurveType.bounce,
                      );
                    },
                    child: Text(
                      'Sign in',
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