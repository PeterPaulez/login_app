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
    return Positioned(
      bottom: 30,
      left: 0, // Esto es para que el COLUMN pueda calcular el ancho
      right: 0, // Esto es para que el COLUMN pueda calcular el ancho
      child: Column(
        children: <Widget>[
          InputTextWidget(
            labelText: 'EMAIL ADDRESS',
            keyboardType: TextInputType.emailAddress,
          ),
          InputTextWidget(
            labelText: 'PASSWORD',
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
