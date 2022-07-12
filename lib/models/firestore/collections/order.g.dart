// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserOrder _$UserOrderFromJson(Map<String, dynamic> json) => UserOrder(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      orderNumber: json['order_number'] as int,
      mode: $enumDecode(_$OrderModeEnumMap, json['mode']),
      status: $enumDecode(_$OrderStatusEnumMap, json['status']),
      method: $enumDecode(_$PaymentMethodEnumMap, json['method']),
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      outlet: Outlet.fromJson(json['outlet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserOrderToJson(UserOrder instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'order_number': instance.orderNumber,
      'mode': _$OrderModeEnumMap[instance.mode],
      'status': _$OrderStatusEnumMap[instance.status],
      'method': _$PaymentMethodEnumMap[instance.method],
      'items': instance.items.map((e) => e.toJson()).toList(),
      'outlet': instance.outlet.toJson(),
    };

const _$OrderModeEnumMap = {
  OrderMode.eatingIn: 'eatingIn',
  OrderMode.takingAway: 'takingAway',
};

const _$OrderStatusEnumMap = {
  OrderStatus.preparing: 'preparing',
  OrderStatus.overdue: 'overdue',
  OrderStatus.completed: 'completed',
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.cash: 'cash',
  PaymentMethod.cardDetails: 'cardDetails',
  PaymentMethod.googlePay: 'googlePay',
};
