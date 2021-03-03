import 'package:flutter/material.dart';

class InputTextWidget extends StatelessWidget {
  final String labelText;
  final TextInputType keyboardType;
  final bool obscureText;
  const InputTextWidget({
    Key key,
    this.labelText = '',
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: this.keyboardType,
      obscureText: this.obscureText,
      decoration: InputDecoration(
        labelText: this.labelText,
        labelStyle:
            TextStyle(color: Colors.black45, fontWeight: FontWeight.w500),
      ),
    );
  }
}
