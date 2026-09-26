part of 'package:catat_uang/import_url_file.dart';

@immutable
class PlannerBookListModel {
  final Pagination? pagination;
  final List<BooksItem>? booksItem;

  const PlannerBookListModel({
    required this.pagination,
    required this.booksItem,
  });

  factory PlannerBookListModel.fromJson(Map<dynamic, dynamic> json) =>
      PlannerBookListModel(
        pagination: Pagination.fromJson(json["pagination"]),
        booksItem: json["data"] != null
            ? List<BooksItem>.from(
                json["data"].map((x) => BooksItem.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination!.toJson(),
        "books_item": List<dynamic>.from(booksItem!.map((x) => x.toJson())),
      };
}

class BooksItem {
  int? id;
  String? name;
  String? targetStart;
  String? targetEnd;
  int? targetAmount;
  int? userId;

  BooksItem({
    required this.id,
    required this.name,
    required this.targetStart,
    required this.targetEnd,
    required this.targetAmount,
    required this.userId,
  });

  factory BooksItem.fromJson(Map<String, dynamic> json) => BooksItem(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        targetStart: json["target_start"] ?? "",
        targetEnd: json["target_end"] ?? "",
        targetAmount: json["target_amount"] ?? 0,
        userId: json["user_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "target_start": targetStart,
        "target_end": targetEnd,
        "target_amount": targetAmount,
        "user_id": userId,
      };
}
