import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skip_q_lah/models/constants.dart';
import 'package:skip_q_lah/models/firestore/collections/item.dart';
import 'package:skip_q_lah/models/firestore/collections/outlet.dart';

class CreateOrderProvider extends ChangeNotifier {
  Outlet? outlet;
  List<Item> items = [];
  OrderMode mode = OrderMode.takingAway;
  PaymentMethod method = PaymentMethod.cash;

  void pendOrder() async {
    FirebaseFirestore fs = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await fs
        .collection('orders')
        .where(
          'outlet',
          isEqualTo: fs.collection('outlets').doc(outlet?.id),
        )
        .where('status', isNotEqualTo: 'completed')
        .get();

    int orderNumber = querySnapshot.size + 1;

    JsonResponse order = {
      'user_id': FirebaseAuth.instance.currentUser!.uid,
      'items': items
          .map(
            (e) => FirebaseFirestore.instance.collection('items').doc(e.id),
          )
          .toList(),
      'outlet':
          FirebaseFirestore.instance.collection('outlets').doc(outlet?.id),
      'order_number': orderNumber,
      'order_mode': $OrderModeEnumMap[mode],
      'payment_method': $PaymentMethodEnumMap[method],
      'status': $OrderStatusEnumMap[OrderStatus.preparing],
    };

    fs.collection('orders').add(order);
  }

  void beginOrder(Outlet outlet) {
    if (this.outlet != outlet) {
      this.outlet = outlet;
      items = [];
      mode = OrderMode.takingAway;
      method = PaymentMethod.cash;
    }

    notifyListeners();
  }

  void addItem(Item item) {
    items.add(item);

    sortItems();
  }

  void removeItem(Item item) {
    items.remove(item);

    sortItems();
  }

  void sortItems() {
    items.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
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
