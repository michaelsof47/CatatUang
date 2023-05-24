part of 'package:catat_uang/import_url_file.dart';

class LocalManager {
  retrievePlannerBookTitle() async {
    SharedPreferences? sharedpref = await SharedPreferences.getInstance();
    return sharedpref.getString("book_name") ?? "";
  }

  storedPlannerTitleBook(bookName) async {
    SharedPreferences? sharedpref = await SharedPreferences.getInstance();
    return sharedpref.setString("book_name", bookName);
  }

  retrieveLoginStatus() async {
    SharedPreferences? sharedpref = await SharedPreferences.getInstance();
    return sharedpref.getBool("is_login") ?? false;
  }

  storedLoginStatusAccount(loginStatus) async {
    SharedPreferences? sharedpref = await SharedPreferences.getInstance();
    return sharedpref.setBool("is_login", loginStatus);
  }
}
