//////////////////
///GENERAL BASE///
//////////////////
import 'dart:convert';
import 'dart:ui';
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
import 'package:intl/intl.dart';
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

///////////////////
///CUSTOM WIDGET///
///////////////////
part 'widget/custom_header_widget.dart';
part 'widget/custom_menu_button_widget.dart';
part 'widget/custom_shorcut_menu_widget.dart';
part 'widget/custom_appbar_widget.dart';
part 'widget/custom_dropdown_widget.dart';
part 'widget/transaction/custom_transaction_list_widget.dart';
part 'widget/custom_header_no_current_time_widget.dart';

/////////////////
///LINKED PAGE///
/////////////////
part 'view/general/login_page.dart';
part 'view/general/splash_screen_page.dart';
part 'utils/general_utils.dart';
part 'utils/general_package.dart';
part 'style/general_style.dart';
part 'view/general/personal_register_page.dart';
part 'view/general/verify_otp_page.dart';
part 'view/home_navigation_page.dart';
part 'view/personal_role/home_dashboard_page.dart';
part 'view/personal_role/transaction/transaction_page.dart';
part 'view/personal_role/planner/planner_page.dart';
part 'view/profile/profile_page.dart';
part 'view/general/owner_register_page.dart';
