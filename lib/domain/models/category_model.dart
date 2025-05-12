import 'dart:convert';

class CategoryModel {
  final String? slug;
  final String? name;
  final String? url;

  CategoryModel({
    this.slug,
    this.name,
    this.url,
  });

  CategoryModel copyWith({
    String? slug,
    String? name,
    String? url,
  }) =>
      CategoryModel(
        slug: slug ?? this.slug,
        name: name ?? this.name,
        url: url ?? this.url,
      );

  factory CategoryModel.fromRawJson(String str) => CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    slug: json["slug"],
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "name": name,
    "url": url,
  };
}
