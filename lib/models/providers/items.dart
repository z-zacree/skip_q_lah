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
  List<String> mainFilter = [];
  List<String> subFilter = [];
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

    List<String> mainCategories = categories.main;
    List<String> subCategories = categories.sub;

    for (var item in itemList) {
      if (!mainCategories.contains(item.categories.main)) {
        mainCategories.add(item.categories.main);
      }

      for (var subCat in item.categories.sub) {
        if (!subCategories.contains(subCat)) {
          subCategories.add(subCat);
        }
      }
    }

    return categories.sorted();
  }

  Map<String, List<OutletItem>> getOutletItems(Outlet outlet) {
    Map<String, List<OutletItem>> outletItemList = {};
    Categories categories = Categories(
      main: mainFilter.isEmpty ? getCategories().main : mainFilter,
      sub: subFilter.isEmpty ? getCategories().sub : subFilter,
    );
    List<OutletItem> outletItems = getItems(outlet);

    for (String mainCat in categories.main) {
      List<OutletItem> itemList = [];

      for (OutletItem outletItem in outletItems) {
        String oIMain = outletItem.item.categories.main;
        List<String> oISub = outletItem.item.categories.sub;

        if (oIMain == mainCat &&
            oISub.any(
              (element) => categories.sub.contains(element),
            )) itemList.add(outletItem);
      }

      switch (sortBy) {
        case SortOrder.nameAscending:
          itemList.sort((a, b) => a.item.name.compareTo(b.item.name));
          break;
        case SortOrder.priceAscending:
          itemList.sort((a, b) => a.item.price.compareTo(b.item.price));
          break;
        case SortOrder.priceDescending:
          itemList.sort((a, b) => b.item.price.compareTo(a.item.price));
          break;
      }

      itemList.sort(((a, b) {
        if (a.isAvailable) return -1;
        if (b.isAvailable) return 1;
        return 0;
      }));

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

  void setMainFilter(String filter) {
    if (mainFilter.contains(filter)) {
      mainFilter.removeWhere((_filter) => _filter == filter);
    } else {
      mainFilter.add(filter);
    }

    notifyListeners();
  }

  void setSubFilter(String filter) {
    if (subFilter.contains(filter)) {
      subFilter.removeWhere((_filter) => _filter == filter);
    } else {
      subFilter.add(filter);
    }

    notifyListeners();
  }
}

class Categories {
  List<String> main, sub;

  Categories({required this.main, required this.sub});

  JsonResponse toJson() {
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

  Categories sorted() {
    main.sort();
    sub.sort();

    return this;
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
