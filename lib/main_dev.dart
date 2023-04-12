import 'package:catat_uang/import_url_file.dart';
import 'package:catat_uang/main.dart';
import 'package:catat_uang/main_config.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main(List<String> args) {
  GeneralPackage.initFirebase();
  var configureMain =
      MainConfig(flavorIndicator: "cu_development", child: const MyApp());

  runApp(configureMain);
}
