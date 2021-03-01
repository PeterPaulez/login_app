import 'package:flutter/material.dart';
import 'dart:math' as math;

class Responsive {
  double _width, _height, _diagonal;

  static Responsive of(BuildContext context) => Responsive(context);

  Responsive(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    this._width = size.width;
    this._height = size.height;
    this._diagonal = math.sqrt(math.pow(_width, 2) + math.pow(_height, 2));
  }

  double get width => this._width;
  double get height => this._height;
  double get diagonal => this._diagonal;

  double withPercent(double percent) => this._width * percent / 100;
  double heightPercent(double percent) => this._height * percent / 100;
  double diagonalPercent(double percent) => this._diagonal * percent / 100;
}
