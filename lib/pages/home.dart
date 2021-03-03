import 'package:api_login_app/utils/responsive.dart';
import 'package:api_login_app/widgets/circle.dart';
import 'package:api_login_app/widgets/icon.dart';
import 'package:api_login_app/widgets/loginForm.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final double sizeBasePink = responsive.withPercent(80);
    final double sizeBaseOrange = responsive.withPercent(57);

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            // Hay que poner un tamaño fijo para que no reviente el ScrollView
            height: responsive.height,
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
                  child: Column(
                    children: [
                      IconWidget(size: responsive.withPercent(17)),
                      SizedBox(height: responsive.diagonalPercent(3)),
                      Text(
                        'Hello again\nWelcome Back!!!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: responsive.diagonalPercent(1.6),
                        ),
                      ),
                    ],
                  ),
                ),
                LoginFormWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
