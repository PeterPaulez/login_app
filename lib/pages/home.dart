import 'package:api_login_app/widgets/circle.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              top: -100,
              left: -50,
              child: CircleWidget(
                size: 200.0,
                colors: [Colors.orange, Colors.deepOrangeAccent],
              ),
            )
          ],
        ),
      ),
    );
  }
}
