import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvatarRegisterWidget extends StatelessWidget {
  final double imageSize;
  const AvatarRegisterWidget({
    Key key,
    this.imageSize = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          // Este margen vale para el Stack del +
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black45,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw9cnEvZ98kadKb7ZIhW20sXOTNVlEsH1q4Q&usqp=CAU',
              height: this.imageSize,
              width: this.imageSize,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CupertinoButton(
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                color: Colors.pink,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: Colors.white),
            ),
            borderRadius: BorderRadius.circular(30),
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }
}
