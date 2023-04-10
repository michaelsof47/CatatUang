import 'package:flutter/material.dart';

class ColorsTheme {
  static Color barStatusColor = const Color(0xff000000);

  /////////////////////////
  ///COLOR WITHOUT ALPHA///
  /////////////////////////
  static Color green = const Color(0xff4C8C4A);
  static Color black = const Color(0xff000000);
  static Color yellow = const Color(0xffFDD835);

  //////////////////////
  ///COLOR WITH ALPHA///
  //////////////////////
  static Color black25 =
      HSLColor.fromColor(Color(0xff000000)).withAlpha(0.2).toColor();
}
