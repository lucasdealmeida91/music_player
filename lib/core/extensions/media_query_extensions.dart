import 'package:flutter/material.dart';

extension MediaQueryExtensions on BuildContext{
  double get getHeight => MediaQuery.of(this).size.height;
  double get getwidth => MediaQuery.of(this).size.width;
  double get getPaddingTop => MediaQuery.of(this).padding.top;
}