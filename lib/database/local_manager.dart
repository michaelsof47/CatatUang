part of 'package:catat_uang/import_url_file.dart';

class LocalManager {
  final sharedPref = CustomSharedPreference();

  retrievePlannerBookTitle() async =>
      await sharedPref.getString("book_name") ?? "";

  storedPlannerTitleBook(bookName) async =>
      await sharedPref.setString("book_name", bookName);

  retrieveLoginStatus() async => await sharedPref.getBool("is_login") ?? false;

  storedLoginStatusAccount(loginStatus) async =>
      await sharedPref.setBool("is_login", loginStatus);

  storedTokenAndUserIdAccount({required Map<String, dynamic> map}) async {
    String? dataMap = jsonEncode(map);
    return sharedPref.setString("token", dataMap);
  }

  retrieveTokenAndUserIdAccount() async {
    if (sharedPref.getString("token") != "") {
      Map<String, dynamic>? dataMap =
          jsonDecode((await sharedPref.getString("token"))!);
      return dataMap;
    } else {
      return {};
    }
  }

  storedBalanceId({required String balanceId}) async =>
      await sharedPref.setString("balance_id", balanceId);

  retrieveBalanceId() async => await sharedPref.getString("balance_id") ?? "";
}
