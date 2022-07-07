import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Item {
  final String id, name, displayImage;
  final double price;
  final List<String> availableAt;
  final ItemCategories categories;

  Item({
    required this.id,
    required this.name,
    required this.displayImage,
    required this.price,
    required this.availableAt,
    required this.categories,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  factory Item.fromFire(String id, Map<String, dynamic> json) {
    json['id'] = id;
    return Item.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ItemCategories {
  final String main;
  final List<String> sub;

  ItemCategories({required this.main, required this.sub});
  factory ItemCategories.fromJson(Map<String, dynamic> json) =>
      _$ItemCategoriesFromJson(json);

  Map<String, dynamic> toJson() => _$ItemCategoriesToJson(this);
}
