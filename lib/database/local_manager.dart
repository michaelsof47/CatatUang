part of 'package:catat_uang/import_url_file.dart';

class LocalManager {
  retrievePlannerBookTitle() async {
    SharedPreferences? sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString("book_name") ?? "";
  }

  storedPlannerTitleBook(bookName) async {
    SharedPreferences? sharedPref = await SharedPreferences.getInstance();
    return sharedPref.setString("book_name", bookName);
  }

  retrieveLoginStatus() async {
    SharedPreferences? sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getBool("is_login") ?? false;
  }

  storedLoginStatusAccount(loginStatus) async {
    SharedPreferences? sharedPref = await SharedPreferences.getInstance();
    return sharedPref.setBool("is_login", loginStatus);
  }

  storedTokenAndUserIdAccount({required Map<String,dynamic> map}) async {
    SharedPreferences? sharedPref = await SharedPreferences.getInstance();
    String? dataMap = jsonEncode(map);
    return sharedPref.setString("token", dataMap);
  }

  retrieveTokenAndUserIdAccount() async {
    SharedPreferences? sharedPref = await SharedPreferences.getInstance();
    if (sharedPref.getString("token") != "") {
      Map<String,dynamic>? dataMap = jsonDecode(sharedPref.getString("token")!);
      return dataMap;
    } else {
      return {};
    }
  }

  storedBalanceId({required String balanceId}) async {
    SharedPreferences? sharedPref = await SharedPreferences.getInstance();
    return sharedPref.setString("balance_id", balanceId);
  }

  retrieveBalanceId() async {
    SharedPreferences? sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString("balance_id") ?? "";
  }
}
