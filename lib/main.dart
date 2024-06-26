import 'package:catat_uang/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'import_url_file.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    materialApp() => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (context) => SplashScreenPage(),
              '/login': (context) => LoginPage(),
              '/register': (context) => RegisterUserPage(),
              '/verify_otp': (context) => VerifyOTPPage(),
              '/home_navigation': (context) => HomeNavigationPage(),
              '/owner_register': (context) => OwnerRegisterPage(),
              '/planner_form': (context) => PlannerPage(),
              '/category_transaction_form': (context) =>
                  CategoryTransactionForm(),
              '/transaction_page': (context) => TransactionPage(),
              /*'/owner_add_product': (context) => ProductPage(),
              '/owner_add_product_form': (context) => AddProductFormPage(),
              '/point_of_sales': (context) => POSPage(),
              '/hutang_piutang': (context) => DebtLoanBookPage(),
              '/camera': (context) => CameraPage(),*/
            });

    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, widget) => materialApp(),
      minTextAdapt: true,
    );
  }
}
