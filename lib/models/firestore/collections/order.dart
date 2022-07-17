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

  String get orderNumberString {
    if (orderNumber < 10) {
      return '00$orderNumber';
    } else if (orderNumber < 100) {
      return '0$orderNumber';
    } else {
      return orderNumber.toString();
    }
  }

  String get orderModeString {
    switch (orderMode) {
      case OrderMode.eatingIn:
        return 'Eating in';
      case OrderMode.takingAway:
        return 'Taking away';
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
}
