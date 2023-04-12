import 'package:catat_uang/main.dart';
import 'package:catat_uang/main_config.dart';
import 'package:flutter/material.dart';
import 'import_url_file.dart';

void main(List<String> args) {
  GeneralPackage.initFirebase();
  var configureMain =
      MainConfig(flavorIndicator: "cu_production", child: const MyApp());

  runApp(configureMain);
}
