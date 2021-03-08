import 'package:api_login_app/pages/login.dart';
import 'package:api_login_app/utils/responsive.dart';
import 'package:api_login_app/widgets/avatarRegister.dart';
import 'package:api_login_app/widgets/circle.dart';
import 'package:api_login_app/widgets/registerForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transitioner/transitioner.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = 'register';
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final double sizeBasePink = responsive.withPercent(88);
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
                  top: -sizeBasePink * 0.3,
                  right: -sizeBasePink * 0.2,
                  child: CircleWidget(
                    size: sizeBasePink,
                    colors: [Colors.pinkAccent, Colors.pink],
                  ),
                ),
                Positioned(
                  top: -sizeBaseOrange * 0.35,
                  left: -sizeBaseOrange * 0.15,
                  child: CircleWidget(
                    size: sizeBaseOrange,
                    colors: [Colors.orange, Colors.deepOrangeAccent],
                  ),
                ),
                Positioned(
                  top: sizeBasePink * 0.25,
                  child: Column(
                    children: [
                      Text(
                        'Hello!\nSign up to get started.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: responsive.diagonalPercent(1.6),
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: responsive.withPercent(5)),
                      AvatarRegisterWidget(
                          imageSize: responsive.withPercent(25))
                    ],
                  ),
                ),
                RegisterFormWidget(),
                Positioned(
                  left: 15,
                  top: 10,
                  child: SafeArea(
                    child: CupertinoButton(
                      color: Colors.black26,
                      child: Icon(Icons.arrow_back),
                      borderRadius: BorderRadius.circular(30),
                      padding: EdgeInsets.all(10),
                      onPressed: () {
                        Transitioner(
                          context: context,
                          child: LoginPage(),
                          animation: AnimationType.slideRight,
                          duration: Duration(milliseconds: 2000),
                          replacement: true,
                          curveType: CurveType.bounce,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
