import 'package:api_login_app/widgets/circle.dart';
import 'package:api_login_app/widgets/icon.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double sizeBasePink = size.width * 0.8;
    final double sizeBaseOrange = size.width * 0.57;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: -sizeBasePink * 0.4,
              right: -sizeBasePink * 0.2,
              child: CircleWidget(
                size: sizeBasePink,
                colors: [Colors.pinkAccent, Colors.pink],
              ),
            ),
            Positioned(
              top: -sizeBaseOrange * 0.55,
              left: -sizeBaseOrange * 0.15,
              child: CircleWidget(
                size: sizeBaseOrange,
                colors: [Colors.orange, Colors.deepOrangeAccent],
              ),
            ),
            Positioned(
              top: sizeBasePink * 0.35,
              child: IconWidget(size: size.width * 0.17),
            ),
          ],
        ),
      ),
    );
  }
}
