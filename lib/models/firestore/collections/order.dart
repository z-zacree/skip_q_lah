import 'package:json_annotation/json_annotation.dart';
import 'package:skip_q_lah/models/constants.dart';

import 'item.dart';
import 'outlet.dart';

part 'order.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class UserOrder {
  String id, userId;
  int orderNumber;
  OrderMode orderMode;
  OrderStatus status;
  PaymentMethod paymentMethod;
  List<Item> items;
  Outlet outlet;

  UserOrder({
    required this.id,
    required this.userId,
    required this.orderNumber,
    required this.orderMode,
    required this.status,
    required this.paymentMethod,
    required this.items,
    required this.outlet,
  });

  JsonResponse toJson() => _$UserOrderToJson(this);

  factory UserOrder.fromJson(JsonResponse json) => _$UserOrderFromJson(json);

  factory UserOrder.fromFire(String id, JsonResponse json) {
    json['id'] = id;

    return UserOrder.fromJson(json);
  }

  
}
