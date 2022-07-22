import 'package:json_annotation/json_annotation.dart';

// Orders
enum OrderStatus { preparing, overdue, completed }

@JsonEnum(fieldRename: FieldRename.snake)
enum OrderMode { eatingIn, takeaway }

@JsonEnum(fieldRename: FieldRename.snake)
enum PaymentMethod { cash, cardDetails, googlePay }

// Outlets
@JsonEnum(fieldRename: FieldRename.snake)
enum ServiceType { notAvailable, pickup, tableDelivery }

// Items
enum SortOrder { nameAscending, priceAscending, priceDescending }

final $OrderStatusEnumMap = {
  OrderStatus.preparing: 'preparing',
  OrderStatus.overdue: 'overdue',
  OrderStatus.completed: 'completed',
};

final $OrderModeEnumMap = {
  OrderMode.eatingIn: 'eating_in',
  OrderMode.takeaway: 'takeaway',
};

final $PaymentMethodEnumMap = {
  PaymentMethod.cash: 'cash',
  PaymentMethod.cardDetails: 'card_details',
  PaymentMethod.googlePay: 'google_pay',
};

final $ServiceTypeEnumMap = {
  ServiceType.notAvailable: 'not_available',
  ServiceType.pickup: 'pickup',
  ServiceType.tableDelivery: 'table_delivery',
};
