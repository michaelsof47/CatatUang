import 'package:catat_uang/main.dart';
import 'package:catat_uang/main_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'import_url_file.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

import 'firebase_options.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };

  var configureMain = MainConfig(
      flavorIndicator: "cu_production",
      child: const ProviderScope(
        child: MyApp(),
      ));

  runApp(configureMain);
}
