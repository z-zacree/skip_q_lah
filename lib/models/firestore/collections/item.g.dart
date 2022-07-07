// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['id'] as String,
      name: json['name'] as String,
      displayImage: json['display_image'] as String,
      price: (json['price'] as num).toDouble(),
      availableAt: (json['available_at'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      categories:
          ItemCategories.fromJson(json['categories'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'display_image': instance.displayImage,
      'price': instance.price,
      'available_at': instance.availableAt,
      'categories': instance.categories.toJson(),
    };

ItemCategories _$ItemCategoriesFromJson(Map<String, dynamic> json) =>
    ItemCategories(
      main: json['main'] as String,
      sub: (json['sub'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ItemCategoriesToJson(ItemCategories instance) =>
    <String, dynamic>{
      'main': instance.main,
      'sub': instance.sub,
    };
