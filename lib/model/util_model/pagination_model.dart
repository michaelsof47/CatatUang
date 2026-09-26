part of 'package:catat_uang/import_url_file.dart';

@immutable
class Pagination {
    int? currentPage;
    int? pageSize;
    int? totalItems;

    Pagination({
        required this.currentPage,
        required this.pageSize,
        required this.totalItems,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["currentPage"] ?? 0,
        pageSize: json["pageSize"] ?? 0,
        totalItems: json["totalItems"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "currentPage": currentPage,
        "pageSize": pageSize,
        "totalItems": totalItems,
    };
}
