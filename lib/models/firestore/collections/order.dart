import 'package:json_annotation/json_annotation.dart';
import 'package:skip_q_lah/models/constants.dart';
import 'package:skip_q_lah/models/enums.dart';

import 'item.dart';
import 'outlet.dart';

part 'order.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class UserOrder {
  String id, userId;
  Identity identity;
  OrderMode orderMode;
  OrderStatus status;
  PaymentMethod paymentMethod;
  List<Item> items;
  Outlet outlet;

  UserOrder({
    required this.id,
    required this.userId,
    required this.identity,
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

  String get identityNumber => identity.orderNumber.toString().padLeft(3, '0');

  ServiceType get identityType => identity.type;

  String get orderModeAsString {
    switch (orderMode) {
      case OrderMode.eatingIn:
        return 'Eating in';
      case OrderMode.takeaway:
        return 'Takeaway';
      default:
        return 'Eating in';
    }
  }

  List<MapEntry<Item, int>> getItemMapEntries() {
    Map<Item, int> itemMap = {};

    // ignore: avoid_function_literals_in_foreach_calls
    items.forEach((_item) => itemMap[_item] =
        !itemMap.containsKey(_item) ? (1) : (itemMap[_item]! + 1));

    return itemMap.entries.toList();
  }

  double getTotalPrice() {
    double totalPrice = 0;

    for (Item item in items) {
      totalPrice += item.price;
    }

    return totalPrice;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Identity {
  final int orderNumber;
  int? tableNumber;
  final ServiceType type;

  Identity({
    required this.orderNumber,
    required this.type,
    this.tableNumber,
  });

  JsonResponse toJson() => _$IdentityToJson(this);

  factory Identity.fromJson(JsonResponse json) => _$IdentityFromJson(json);
}
