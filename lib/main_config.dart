import 'package:flutter/material.dart';

class MainConfig extends InheritedWidget {
  String? flavorIndicator;

  MainConfig({
    Key? key,
    Widget? child,
    required this.flavorIndicator,
  }) : super(key: key, child: child!);

  static MainConfig of(context) =>
      context.dependOnInheritedWidgetOfExactType<MainConfig>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
