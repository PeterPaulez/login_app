import 'package:flutter/material.dart';

class InitPage extends StatefulWidget {
  static const routeName = 'init';
  InitPage({Key key}) : super(key: key);

  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Empty Page'),
        actions: [],
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
