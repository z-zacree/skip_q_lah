import 'package:flutter/cupertino.dart';
import 'package:skip_q_lah/models/firestore/collections/item.dart';
import 'package:skip_q_lah/models/firestore/collections/order.dart';
import 'package:skip_q_lah/models/firestore/collections/outlet.dart';

class OrderProvider extends ChangeNotifier {
  List<Order> userOrders = [];

  void pendOrder() {
    userOrders.add(order!);

    order = null;
  }

  Order? order;

  void beginNewOrder(Outlet outlet) {
    order = Order.blank(outlet);
    notifyListeners();
  }

  void addItemCount(Item item, int count) {
    for (int i = 0; i < count; i++) {
      order?.itemList.add(item);
    }

    sortItems();
  }

  void addItem(Item item) {
    order?.itemList.add(item);

    sortItems();
  }

  void removeItem(Item item) {
    order?.itemList.remove(item);

    sortItems();
  }

  void sortItems() {
    order?.itemList.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  void resetOrder() {
    order = null;
    notifyListeners();
  }
}
