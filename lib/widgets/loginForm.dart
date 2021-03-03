import 'package:api_login_app/utils/responsive.dart';
import 'package:api_login_app/widgets/inputText.dart';
import 'package:flutter/material.dart';

class LoginFormWidget extends StatefulWidget {
  LoginFormWidget({Key key}) : super(key: key);

  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTablet ? 430 : 360,
        ),
        child: Column(
          children: <Widget>[
            InputTextWidget(
              labelText: 'EMAIL ADDRESS',
              keyboardType: TextInputType.emailAddress,
              fontSize: responsive.diagonalPercent(1.4),
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
              onPressed: () {},
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
                  'New to Friendly Desi?',
                  style: TextStyle(
                    fontSize: responsive.diagonalPercent(1.5),
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
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
    );
  }
}
