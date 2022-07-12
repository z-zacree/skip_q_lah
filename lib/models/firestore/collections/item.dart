import 'package:json_annotation/json_annotation.dart';
import 'package:skip_q_lah/models/constants.dart';

part 'item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Item {
  final String id, name, displayImage, additionalInfo;
  final double price;
  final List<String> availableAt;
  final ItemCategories categories;

  const Item({
    required this.id,
    required this.name,
    required this.displayImage,
    required this.additionalInfo,
    required this.price,
    required this.availableAt,
    required this.categories,
  });

  factory Item.fromJson(JsonResponse json) => _$ItemFromJson(json);

  factory Item.fromFire(String id, JsonResponse json) {
    json['id'] = id;
    json['additional_info'] = '';
    return Item.fromJson(json);
  }

  JsonResponse toJson() => _$ItemToJson(this);

  String getPrice() {
    return '\$' + price.toStringAsFixed(2);
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ItemCategories {
  final String main;
  final List<String> sub;

  ItemCategories({required this.main, required this.sub});
  factory ItemCategories.fromJson(JsonResponse json) =>
      _$ItemCategoriesFromJson(json);

  JsonResponse toJson() => _$ItemCategoriesToJson(this);
}
