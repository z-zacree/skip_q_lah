// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as String,
      outlet: Outlet.fromJson(json['outlet'] as Map<String, dynamic>),
      itemList: (json['item_list'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      isTakeaway: json['is_takeaway'] as bool,
      relativeWaitingTime: json['relative_waiting_time'] as int,
      isCompleted: json['is_completed'] as bool,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'outlet': instance.outlet.toJson(),
      'item_list': instance.itemList.map((e) => e.toJson()).toList(),
      'relative_waiting_time': instance.relativeWaitingTime,
      'is_takeaway': instance.isTakeaway,
      'is_completed': instance.isCompleted,
    };
