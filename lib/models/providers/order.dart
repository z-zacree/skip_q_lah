import 'package:flutter/cupertino.dart';
import 'package:skip_q_lah/models/firestore/collections/item.dart';
import 'package:skip_q_lah/models/firestore/collections/order.dart';

class OrderProvider extends ChangeNotifier {
  Order order = Order.blank();

  void addItemCount(Item item, int count) {
    for (int i = 0; i < count; i++) {
      order.itemList.add(item);
    }

    sortItems();
    notifyListeners();
  }

  void addItem(Item item) {
    order.itemList.add(item);

    sortItems();
    notifyListeners();
  }

  void sortItems() {
    order.itemList.sort((a, b) => a.name.compareTo(b.name));
  }

  void resetOrder() {
    order = Order.blank();
    notifyListeners();
  }
}
