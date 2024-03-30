part of 'package:catat_uang/import_url_file.dart';
class ColorsTheme {
  static Color barStatusColor = const Color(0xff000000);

  /////////////////////////
  ///COLOR WITHOUT ALPHA///
  /////////////////////////
  static Color green = const Color(0xff4C8C4A);
  static Color black = const Color(0xff000000);
  static Color yellow = const Color(0xffFDD835);
  static Color white = const Color(0xffFFFFFF);
  static Color grey = const Color(0xffBFBFBF);
  static Color facebookColor = const Color(0xff1877F2);
  static Color googleColor = const Color(0xff4285F4);
  static Color yellowSoft = const Color(0xffF3F4CB);
  static Color yellowHard = const Color(0xffBBBC93);
  static Color redSoft = const Color(0xffF36E62);
  static Color greenNature = const Color(0xffF3F4CB);

  //////////////////////
  ///COLOR WITH ALPHA///
  //////////////////////
  static Color black25 =
      HSLColor.fromColor(Color(0xff000000)).withAlpha(0.2).toColor();

  ////////////////////////
  ///COLOR WITH OPACITY///
  ////////////////////////

  static Color transparent = const Color(0xFFFFFFFF).withOpacity(0);
}
