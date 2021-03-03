import 'package:flutter/material.dart';

class InputTextWidget extends StatelessWidget {
  final String labelText;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool borderEnabled;
  const InputTextWidget(
      {Key key,
      this.labelText = '',
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.borderEnabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: this.keyboardType,
      obscureText: this.obscureText,
      decoration: InputDecoration(
        enabledBorder: this.borderEnabled
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black12))
            : InputBorder.none,
        labelText: this.labelText,
        contentPadding: EdgeInsets.symmetric(vertical: 5),
        labelStyle: TextStyle(
          color: Colors.black45,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
