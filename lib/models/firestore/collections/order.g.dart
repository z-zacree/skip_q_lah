// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserOrder _$UserOrderFromJson(Map<String, dynamic> json) => UserOrder(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      identity: Identity.fromJson(json['identity'] as Map<String, dynamic>),
      orderMode: $enumDecode(_$OrderModeEnumMap, json['order_mode']),
      status: $enumDecode(_$OrderStatusEnumMap, json['status']),
      paymentMethod:
          $enumDecode(_$PaymentMethodEnumMap, json['payment_method']),
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      outlet: Outlet.fromJson(json['outlet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserOrderToJson(UserOrder instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'identity': instance.identity.toJson(),
      'order_mode': _$OrderModeEnumMap[instance.orderMode],
      'status': _$OrderStatusEnumMap[instance.status],
      'payment_method': _$PaymentMethodEnumMap[instance.paymentMethod],
      'items': instance.items.map((e) => e.toJson()).toList(),
      'outlet': instance.outlet.toJson(),
    };

const _$OrderModeEnumMap = {
  OrderMode.eatingIn: 'eating_in',
  OrderMode.takeaway: 'takeaway',
};

const _$OrderStatusEnumMap = {
  OrderStatus.preparing: 'preparing',
  OrderStatus.overdue: 'overdue',
  OrderStatus.completed: 'completed',
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.cash: 'cash',
  PaymentMethod.cardDetails: 'card_details',
  PaymentMethod.googlePay: 'google_pay',
};

Identity _$IdentityFromJson(Map<String, dynamic> json) => Identity(
      orderNumber: json['order_number'] as int,
      type: $enumDecode(_$ServiceTypeEnumMap, json['type']),
      tableNumber: json['table_number'] as int?,
    );

Map<String, dynamic> _$IdentityToJson(Identity instance) => <String, dynamic>{
      'order_number': instance.orderNumber,
      'table_number': instance.tableNumber,
      'type': _$ServiceTypeEnumMap[instance.type],
    };

const _$ServiceTypeEnumMap = {
  ServiceType.notAvailable: 'not_available',
  ServiceType.pickup: 'pickup',
  ServiceType.tableDelivery: 'table_delivery',
};
