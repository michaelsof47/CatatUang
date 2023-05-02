//////////////////
///GENERAL BASE///
//////////////////
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';

///////////////////////////////
///FIREBASE / GOOGLE LIBRARY///
///////////////////////////////
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'firebase_options.dart';

////////////////////
///CUSTOM LIBRARY///
////////////////////
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sms_autofill/sms_autofill.dart';

///////////////////////
///CUSTOM UTILS PAGE///
///////////////////////
import '../style/colors_theme.dart';

////////////////////
///PROVIDER UTILS///
////////////////////
part 'utils/general_provider.dart';

/////////////////
///LINKED PAGE///
/////////////////
part 'view/general/login_page.dart';
part 'view/general/splash_screen_page.dart';
part 'utils/general_utils.dart';
part 'utils/general_package.dart';
part 'style/general_style.dart';
part 'view/general/register_user.dart';
part 'view/general/verify_otp_page.dart';
part 'view/home_navigation_page.dart';
part 'view/home_dashboard_page.dart';
part 'view/transaction/transaction_page.dart';
part 'view/planner/planner_page.dart';
part 'view/profile/profile_page.dart';
