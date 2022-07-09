import 'package:json_annotation/json_annotation.dart';

import 'item.dart';
import 'outlet.dart';

part 'order.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Order {
  String id;
  Outlet outlet;
  List<Item> itemList;
  int relativeWaitingTime;
  bool isTakeaway, isCompleted;

  Order({
    required this.id,
    required this.outlet,
    required this.itemList,
    required this.isTakeaway,
    required this.relativeWaitingTime,
    required this.isCompleted,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  factory Order.blank(Outlet outlet) => Order(
        id: '',
        outlet: outlet,
        itemList: [],
        isCompleted: false,
        isTakeaway: false,
        relativeWaitingTime: 1,
      );

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  List<MapEntry<Item, int>> getItemMapEntries() {
    Map<Item, int> itemMap = {};

    // ignore: avoid_function_literals_in_foreach_calls
    itemList.forEach((_item) => itemMap[_item] =
        !itemMap.containsKey(_item) ? (1) : (itemMap[_item]! + 1));

    return itemMap.entries.toList();
  }

  double getTotalPrice() {
    double totalPrice = 0;

    for (var item in itemList) {
      totalPrice += item.price;
    }

    return totalPrice;
  }
}
