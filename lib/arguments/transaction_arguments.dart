
import 'package:catat_uang/import_url_file.dart';

class TransactionArguments {
  List<CategoryItem>? categories;
  String? initialCategoryName;
  String? initCategoryId;
  int? budget;

  TransactionArguments(this.categories, this.initialCategoryName, this.initCategoryId, this.budget);
}