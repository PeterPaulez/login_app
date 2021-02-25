import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  final double size;
  final List<Color> colors;

  CircleWidget({Key key, @required this.size, this.colors})
      : assert(size != null && size > 0),
        assert(colors != null && colors.length >= 2),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: this.colors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: null,
    );
  }
}
