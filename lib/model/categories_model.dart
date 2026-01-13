part of 'package:catat_uang/import_url_file.dart';

class CategoriesModel {
  int? count;
  List<CategoryItem>? detailsItem;

  CategoriesModel({
    required this.count,
    required this.detailsItem,
  });

  factory CategoriesModel.fromJson(Map<dynamic, dynamic> json) =>
      CategoriesModel(
        count: json["count"] ?? 0,
        detailsItem: json["details_item"] != null
            ? List<CategoryItem>.from(
                json["details_item"].map((x) => CategoryItem.fromJson(x)))
            : [],
      );

  Map<dynamic, dynamic> toJson() => {
        "count": count,
        "details_item": List<dynamic>.from(detailsItem!.map((x) => x.toJson())),
      };
}

class CategoryItem {
  int? id;
  String? name;
  String? description;
  String? categoryUrlImage;

  CategoryItem({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryUrlImage,
  });

  factory CategoryItem.fromJson(Map<dynamic, dynamic> json) => CategoryItem(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        description: json["description"] ?? "",
        categoryUrlImage: json["category_url_image"] ?? "",
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "category_url_image": categoryUrlImage,
      };
}
