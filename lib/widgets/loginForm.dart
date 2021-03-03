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
      bottom: 50,
      left: 20, // Esto es para que el COLUMN pueda calcular el ancho
      right: 20, // Esto es para que el COLUMN pueda calcular el ancho
      child: Column(
        children: <Widget>[
          InputTextWidget(
            labelText: 'EMAIL ADDRESS',
            keyboardType: TextInputType.emailAddress,
          ),
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
                  ),
                ),
                MaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  onPressed: () {},
                  child: Text('Forgot Password'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
