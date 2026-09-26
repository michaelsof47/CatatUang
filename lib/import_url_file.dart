///GENERAL BASE///
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:catat_uang/main_config.dart';
import 'package:custom_shared_preference/custom_shared_preference.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

///FIREBASE / GOOGLE LIBRARY///
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shimmer/shimmer.dart';
import 'firebase_options.dart';

///CUSTOM LIBRARY///
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:lottie/lottie.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:realm/realm.dart';

//ARGUMENTS//
import 'package:catat_uang/arguments/transaction_arguments.dart';

///UTILS THEME///
part 'style/colors_theme.dart';
part 'style/font_theme.dart';
part 'style/layout_theme.dart';

///CUSTOM WIDGET///
part 'widget/header/custom_header_widget.dart';
part 'widget/button/custom_menu_button_widget.dart';
part 'widget/general_widget/custom_shorcut_menu_widget.dart';
part 'widget/general_widget/custom_appbar_widget.dart';
part 'widget/general_widget/custom_dropdown_widget.dart';
part 'widget/item_list/custom_transaction_list_widget.dart';
part 'widget/header/custom_header_no_current_time_widget.dart';
part 'widget/button/custom_menu_profile_widget.dart';
part 'widget/bottom_sheet/custom_bs_multi_option_widget.dart';
part 'widget/handling_error/new_document_widget.dart';
part 'widget/bottom_sheet/custom_bs_input_field_widget.dart';
part 'widget/button/custom_single_button_widget.dart';
part 'widget/general_widget/custom_border_form.dart';
part 'widget/button/custom_upload_photo_button_widget.dart';
part 'widget/button/custom_form_action_button_widget.dart';
part 'widget/button/custom_login_form_button_widget.dart';
part 'widget/shimmer/custom_shimmer_card_widget.dart';
part 'widget/shimmer/custom_shimmer_profile_widget.dart';
part 'widget/shimmer/custom_shimmer_card_list_widget.dart';
part 'widget/item_list/custom_planner_list_widget.dart';
part 'widget/bottom_sheet/custom_bs_planner_input_field_widget.dart';

///LOCAL DATABASE///
part 'database/local_manager.dart';

///CONTROLLER///
part 'controller/base_controller.dart';
part 'controller/planner_controller.dart';
part 'controller/login_controller.dart';
part 'controller/dashboard_controller.dart';
part 'controller/transaction_controller.dart';

/////////////////////
///PACKAGE UTILITY///
/////////////////////
//part 'package:catat_uang/package/location_package.dart';
//part 'package:catat_uang/package/dashboard_message_package.dart';

//////////////
///DATABASE///
//////////////
//part 'package:catat_uang/database/transaction_database.dart';

//UTILS//
part 'utils/general_utils.dart';
part 'utils/currency_utils.dart';
part 'utils/app_config.dart';
part 'utils/format_utils.dart';
part 'utils/base_service_config.dart';

//INTERFACE//
part 'interfaces/dasboardservice_interfaces.dart';
part 'interfaces/loginservice_interfaces.dart';
part 'interfaces/transactionservice_interfaces.dart';
part 'interfaces/plannerservice_interfaces.dart';

//MODEL//
part 'model/retrieve_model/login_model.dart';
part 'model/retrieve_model/account_model.dart';
part 'model/retrieve_model/balance_model.dart';
part 'model/retrieve_model/transaction_model.dart';
part 'model/retrieve_model/categories_model.dart';
part 'model/util_model/http_model.dart';
part 'model/retrieve_model/planner_book_list_model.dart';
part 'model/util_model/pagination_model.dart';
part 'model/request_model/create_planner_book_model.dart';

//SERVICE//
part 'service/login_service.dart';
part 'service/dashboard_service.dart';
part 'service/transaction_service.dart';
part 'service/planner_service.dart';

/////////////////
///LINKED PAGE///
/////////////////

//GENERAL//
part 'view/general/onboarding_page.dart';
part 'view/general/login_page.dart';
part 'view/general/splash_screen_page.dart';
part 'view/general/personal_register_page.dart';
part 'view/general/verify_otp_page.dart';
part 'view/home_navigation_page.dart';
part 'view/general/owner_register_page.dart';
part 'view/profile/profile_page.dart';
//part 'view/general/camera_page.dart';
part 'view/profile//profile_form_page.dart';

//PERSONAL ROLE//
part 'view/personal_role/home_dashboard_page.dart';
part 'view/personal_role/transaction/transaction_page.dart';
part 'view/personal_role/planner/planner_page.dart';
part 'view/personal_role/transaction/form/category_form_page.dart';
part 'view/personal_role/transaction/form/transaction_form_page.dart';
part 'view/personal_role/planner/detail_planner_page.dart';

//OWNER ROLE//
//part 'view/owner_role/owner_dashboard_page.dart';
//part 'view/owner_role/product_form/product_page.dart';
//part 'view/owner_role/product_form/owner_add_product_form.dart';
//part 'view/owner_role/point_of_sales/point_of_sales_page.dart';
//part 'view/owner_role/debt_loan_book/debt_loan_book_page.dart';
