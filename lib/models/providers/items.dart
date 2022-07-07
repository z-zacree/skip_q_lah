import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skip_q_lah/models/constants.dart';
import 'package:skip_q_lah/models/firestore/collections/item.dart';
import 'package:skip_q_lah/models/firestore/collections/outlet.dart';

class ItemsProvider extends ChangeNotifier {
  ItemsProvider() {
    FirebaseFirestore.instance.collection("items").snapshots().listen((event) {
      for (var change in event.docChanges) {
        Item changedItem = Item.fromFire(change.doc.id, change.doc.data()!);
        switch (change.type) {
          case DocumentChangeType.added:
            itemList.add(changedItem);
            notifyListeners();
            break;
          case DocumentChangeType.modified:
            itemList.removeWhere((Item item) => item.id == changedItem.id);
            itemList.add(changedItem);
            notifyListeners();
            break;
          case DocumentChangeType.removed:
            itemList.removeWhere((Item item) => item.id == changedItem.id);
            notifyListeners();
            break;
        }
      }
    });
  }

  List<Item> itemList = [];
  Categories filterCategories = Categories(main: [], sub: []);
  SortOrder sortBy = SortOrder.nameAscending;

  List<OutletItem> getItems(Outlet outlet) {
    List<OutletItem> outletItemList = [];

    for (var item in itemList) {
      outletItemList.add(
        OutletItem(
          isAvailable: item.availableAt.contains(outlet.id),
          item: item,
        ),
      );
    }

    return outletItemList;
  }

  Categories getCategories() {
    Categories categories = Categories(main: [], sub: []);

    for (var item in itemList) {
      if (!categories.main.contains(item.categories.main)) {
        categories.main.add(item.categories.main);
      }

      for (var subCat in item.categories.sub) {
        if (!categories.sub.contains(subCat)) {
          categories.sub.add(subCat);
        }
      }
    }

    return categories;
  }

  Map<String, List<OutletItem>> getOutletItems(Outlet outlet) {
    Map<String, List<OutletItem>> outletItemList = {};
    Categories categories = getCategories();
    List<OutletItem> outletItems = getItems(outlet);

    categories.filterOut(filterCategories);

    for (String mainCat in categories.main) {
      List<OutletItem> itemList = [];
      for (OutletItem oi in outletItems) {
        if (oi.item.categories.main == mainCat) itemList.add(oi);
      }

      switch (sortBy) {
        case SortOrder.nameAscending:
          itemList.sort(
            (a, b) => a.item.name.compareTo(b.item.name),
          );
          break;
        case SortOrder.priceAscending:
          itemList.sort(
            (a, b) => a.item.price.compareTo(b.item.price),
          );
          break;
        case SortOrder.priceDescending:
          itemList.sort(
            (a, b) => b.item.price.compareTo(a.item.price),
          );
          break;
      }

      outletItemList.update(
        mainCat,
        (value) => itemList,
        ifAbsent: () => itemList,
      );
    }
    return outletItemList;
  }

  void setSort(SortOrder sortOrder) {
    sortBy = sortOrder;
    notifyListeners();
  }

  bool compareSort(SortOrder sortOrder) {
    return sortBy == sortOrder;
  }

  void setFilter(String filter) {
    if (filterCategories.main.contains(filter)) {
      filterCategories.main.removeWhere((_filter) => _filter == filter);
    } else {
      filterCategories.main.add(filter);
    }

    notifyListeners();
  }
}

class Categories {
  List<String> main, sub;

  Categories({required this.main, required this.sub});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'main': main, 'sub': sub};
  }

  void filterOut(Categories categories) {
    for (var mainCat in categories.main) {
      main.removeWhere((cat) => cat == mainCat);
    }
    for (var subCat in categories.sub) {
      sub.removeWhere((cat) => cat == subCat);
    }
  }

  bool isEmpty() {
    return main.isEmpty && sub.isEmpty;
  }
}

class OutletItem {
  final Item item;
  final bool isAvailable;

  const OutletItem({required this.isAvailable, required this.item});
}