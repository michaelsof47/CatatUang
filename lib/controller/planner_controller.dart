part of 'package:catat_uang/import_url_file.dart';

class PlannerController extends GetxController {
  LocalManager localManager = Get.put(LocalManager());

  storedPlannerBookController(bookName) =>
      localManager.storedPlannerTitleBook(bookName);

  retrievePlannerBookController() => localManager.retrievePlannerBookTitle();
}
