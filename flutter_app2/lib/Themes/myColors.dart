import 'dart:ui';

import 'package:flutter/material.dart';

class MyTheme{
  static Color themeColor = Colors.green;
  static Gradient myLinearGradient = LinearGradient(
    colors: <Color>[
      Color(0xFFC8E6C9),
      Colors.green,


    ],
  );

  static Gradient myVerticalGradient = LinearGradient(
  //  begin: Alignment(-15.0, -1.0), end: Alignment(20.0, 1.0),
    colors: <Color>[
      Color(0xFFC8E6C9),
      Colors.green,


    ],
  );

}