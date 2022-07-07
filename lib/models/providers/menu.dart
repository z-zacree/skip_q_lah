import 'package:flutter/material.dart';
import 'package:skip_q_lah/models/constants.dart';

import 'items.dart';

class MenuProvider extends ChangeNotifier {
  Map<String, List<OutletItem>> itemsByMain = {};
  Categories filterOut = Categories(main: ['Waffles'], sub: []);
  SortOrder sortBy = SortOrder.nameAscending;

  void setItemsByMain(List<OutletItem> itemList, Categories categories) {
    categories.filterOut(filterOut);
    for (String mainCat in categories.main) {
      List<OutletItem> outletItemsByMain = [];
      for (OutletItem oi in itemList) {
        if (oi.item.categories.main == mainCat) outletItemsByMain.add(oi);
      }

      switch (sortBy) {
        case SortOrder.nameAscending:
          outletItemsByMain.sort(
            (a, b) => a.item.name.compareTo(b.item.name),
          );
          break;
        case SortOrder.priceAscending:
          outletItemsByMain.sort(
            (a, b) => a.item.price.compareTo(b.item.price),
          );
          break;
        case SortOrder.priceDescending:
          outletItemsByMain.sort(
            (a, b) => b.item.price.compareTo(a.item.price),
          );
          break;
      }

      itemsByMain.update(
        mainCat,
        (value) => outletItemsByMain,
        ifAbsent: () => outletItemsByMain,
      );
    }
  }

  void setMainFilter(String filteredCategory) {
    if (filterOut.main.contains(filteredCategory)) {
      filterOut.main.remove(filteredCategory);
      itemsByMain = itemsByMain;
    } else {
      filterOut.main.add(filteredCategory);
      itemsByMain = itemsByMain;
    }
    notifyListeners();
  }

  void setSort(SortOrder sortType) {
    sortBy = sortType;
    notifyListeners();
  }

  bool compareSort(SortOrder sortType) {
    return sortBy == sortType;
  }
}
