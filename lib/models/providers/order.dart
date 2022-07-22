import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skip_q_lah/models/constants.dart';
import 'package:skip_q_lah/models/firestore/collections/item.dart';
import 'package:skip_q_lah/models/firestore/collections/order.dart';
import 'package:skip_q_lah/models/firestore/collections/outlet.dart';
import 'package:skip_q_lah/models/firestore/main.dart';
import 'package:skip_q_lah/models/enums.dart';

class CreateOrderProvider extends ChangeNotifier {
  Outlet? outlet;
  List<Item> items = [];
  OrderMode mode = OrderMode.takeaway;
  ServiceType type = ServiceType.notAvailable;
  PaymentMethod method = PaymentMethod.cash;
  int number = -1;

  Future<UserOrder> pendOrder() async {
    FirebaseFirestore fs = FirebaseFirestore.instance;

    if (type == ServiceType.pickup) {
      QuerySnapshot querySnapshot = await fs
          .collection('orders')
          .where(
            'outlet',
            isEqualTo: fs.collection('outlets').doc(outlet?.id),
          )
          .where('status', isNotEqualTo: 'completed')
          .get();

      number = querySnapshot.size + 1;
    }

    List<DocumentReference<JsonResponse>> itemRefs = items
        .map(
          (e) => FirebaseFirestore.instance.collection('items').doc(e.id),
        )
        .toList();

    JsonResponse order = {
      'user_id': FirebaseAuth.instance.currentUser!.uid,
      'identity': {
        'number': number,
        'type': $ServiceTypeEnumMap[type],
      },
      'order_mode': $OrderModeEnumMap[mode],
      'status': $OrderStatusEnumMap[OrderStatus.preparing],
      'payment_method': $PaymentMethodEnumMap[method],
      'items': itemRefs,
      'outlet':
          FirebaseFirestore.instance.collection('outlets').doc(outlet?.id),
    };

    DocumentReference<JsonResponse> docRef =
        await fs.collection('orders').add(order);

    DocumentSnapshot<JsonResponse> doc = await docRef.get();

    UserOrder userOrder =
        await FirestoreService().getUserOrder(doc.id, doc.data()!);

    return userOrder;
  }

  void beginOrder(Outlet outlet) {
    if (this.outlet != outlet) {
      this.outlet = outlet;
      items = [];
      mode = OrderMode.takeaway;
      method = PaymentMethod.cash;
      type = ServiceType.notAvailable;
      number = -1;
    }

    notifyListeners();
  }

  void addItem(Item item) {
    items.add(item);

    sortItems();
  }

  void removeItem(Item item) {
    items.removeWhere((e) => e == item);

    sortItems();
  }

  void sortItems() {
    items.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  void changeOutlet(Outlet outlet) {
    this.outlet = outlet;
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
