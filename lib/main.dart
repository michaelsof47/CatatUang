import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'import_url_file.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    materialApp() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          getPages: [
            GetPage(
                name: "/",
                page: () => SplashScreenPage(),
                binding: SplashScreenBinding()),
            GetPage(
                name: "/onboarding",
                page: () => OnBoardingPage(),
                binding: OnBoardingBinding()),
            GetPage(
                name: "/login",
                page: () => LoginPage(),
                binding: LoginBinding()),
            GetPage(
                name: "/register",
                page: () => RegisterUserPage(),
                binding: RegisterUserBinding()),
            GetPage(
                name: "/profile_form_page",
                page: () => ProfileFormPage(),
                binding: ProfileFormBinding()),
            GetPage(
                name: "/profile_page",
                page: () => ProfilePage(),
                binding: ProfileBinding(),
            ),
            GetPage(
                name: "/transaction_page",
                page: () => TransactionPage(),
                binding: TransactionBinding(),
            ),
            GetPage(
                name: "/category_form",
                page: () => CategoryForm(),
                binding: CategoryFormBinding()),
            GetPage(
                name: "/transaction_form",
                page: () => TransactionForm(),
                binding: TransactionFormBinding()),
            GetPage(
                name: "/planner_form",
                page: () => PlannerPage(),
                binding: PlannerBinding()),
            GetPage(
              name: "/home_navigation",
              page: () => HomeNavigationPage(),
              binding: HomeDashboardBinding(),
            )
          ],
        );

    /*MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (context) => SplashScreenPage(),
              '/onboarding': (context) => OnBoardingPage(),
              '/login': (context) => LoginPage(),
              '/register': (context) => RegisterUserPage(),
              '/verify_otp': (context) => VerifyOTPPage(),
              '/home_navigation': (context) => HomeNavigationPage(),
              '/owner_register': (context) => OwnerRegisterPage(),
              '/planner_form': (context) => PlannerPage(),
              '/category_transaction_form': (context) =>
                  CategoryTransactionForm(),
              '/transaction_page': (context) => TransactionPage(),
              '/profile_form_page': (context) => ProfileFormPage(),
              /*'/owner_add_product': (context) => ProductPage(),
              '/owner_add_product_form': (context) => AddProductFormPage(),
              '/point_of_sales': (context) => POSPage(),
              '/hutang_piutang': (context) => DebtLoanBookPage(),
              '/camera': (context) => CameraPage(),*/
            });*/

    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, widget) => materialApp(),
      minTextAdapt: true,
    );
  }
}
