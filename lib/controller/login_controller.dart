part of 'package:catat_uang/import_url_file.dart';

class LoginController extends GetxController {
  LocalManager? localManager = Get.put(LocalManager());

  storeLoginStatusController(loginStatus) async =>
      await localManager!.storedLoginStatusAccount(loginStatus);

  retrieveLoginStatusController() async =>
      await localManager!.retrieveLoginStatus();
}
