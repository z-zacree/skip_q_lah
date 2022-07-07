import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:skip_q_lah/models/constants.dart';
import 'package:skip_q_lah/models/firestore/collections/outlet.dart';
import 'package:skip_q_lah/models/providers/items.dart';
import 'package:skip_q_lah/widgets/outlet_widgets.dart';
import 'package:skip_q_lah/widgets/reusable_widgets.dart';

class OutletMenu extends StatefulWidget {
  const OutletMenu({Key? key, required this.outlet}) : super(key: key);

  final Outlet outlet;

  @override
  State<OutletMenu> createState() => _OutletMenuState();
}

class _OutletMenuState extends State<OutletMenu> {
  late Map<String, List<OutletItem>> outletItems;

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemsProvider>(
      builder: (
        BuildContext context,
        ItemsProvider itemsProvider,
        Widget? child,
      ) {
        outletItems = itemsProvider.getOutletItems(widget.outlet);

        return Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 110),
                const TextHeader(text: 'Menu'),
                const SizedBox(height: 12),
                ...outletItems.keys
                    .map(
                      (key) => mainCategoryItems(
                        key,
                        outletItems[key]!,
                      ),
                    )
                    .toList(),
              ],
            ),
            Positioned(
              top: 48,
              left: 24,
              child: CircleAvatar(
                radius: 24,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: IconButton(
                  splashRadius: 28,
                  onPressed: () => Navigator.pop(context),
                  icon: FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    size: 18,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 48,
              right: 24,
              child: CircleAvatar(
                radius: 24,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: IconButton(
                  splashRadius: 28,
                  onPressed: () => showCustomModalBottomSheet(
                    context: context,
                    builder: (context) => buildFilterMenu(
                      context,
                      itemsProvider,
                    ),
                    containerWidget: (
                      BuildContext context,
                      Animation<double> animation,
                      Widget child,
                    ) {
                      return SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 32,
                            right: 32,
                            bottom: 32,
                          ),
                          child: Material(
                            clipBehavior: Clip.antiAlias,
                            borderRadius: BorderRadius.circular(12),
                            child: child,
                          ),
                        ),
                      );
                    },
                  ),
                  icon: FaIcon(
                    FontAwesomeIcons.barsStaggered,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

Widget mainCategoryItems(String catName, List<OutletItem> itemList) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextSubHeader(catName),
      const SizedBox(height: 16),
      ...itemList
          .map(
            (outletItem) => ItemTile(
              item: outletItem.item,
              isAvailable: outletItem.isAvailable,
            ),
          )
          .toList(),
      const SizedBox(height: 24)
    ],
  );
}

Widget buildFilterMenu(BuildContext context, ItemsProvider itemsProvider) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Material(
        color: Theme.of(context).backgroundColor,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Sort By',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ListTile(
                selected: itemsProvider.compareSort(SortOrder.priceAscending),
                dense: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: const Text('Price: Low to High'),
                leading: FaIcon(
                  FontAwesomeIcons.arrowUpShortWide,
                  color: Theme.of(context).primaryColorDark,
                ),
                onTap: () {
                  setState(
                    () => itemsProvider.setSort(SortOrder.priceAscending),
                  );
                },
              ),
              ListTile(
                selected: itemsProvider.compareSort(SortOrder.priceDescending),
                dense: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: const Text('Price: High to Low'),
                leading: FaIcon(
                  FontAwesomeIcons.arrowDownWideShort,
                  color: Theme.of(context).primaryColorDark,
                ),
                onTap: () {
                  setState(
                    () => itemsProvider.setSort(SortOrder.priceDescending),
                  );
                },
              ),
              ListTile(
                selected: itemsProvider.compareSort(
                  SortOrder.nameAscending,
                ),
                dense: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: const Text('Name'),
                leading: FaIcon(
                  FontAwesomeIcons.arrowDownAZ,
                  color: Theme.of(context).primaryColorDark,
                ),
                onTap: () {
                  setState(
                    () => itemsProvider.setSort(SortOrder.nameAscending),
                  );
                },
              ),
              const Divider(thickness: 1, indent: 8, endIndent: 8),
              const SizedBox(height: 8),
              const Text(
                'Filter',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 0,
                color: itemsProvider.mainFilter.isEmpty &&
                        itemsProvider.subFilter.isEmpty
                    ? Theme.of(context).backgroundColor
                    : Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    maintainState: true,
                    title: const Text(
                      'Category',
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: FaIcon(
                      FontAwesomeIcons.filter,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    textColor: Theme.of(context).primaryColorDark,
                    collapsedTextColor: Theme.of(context).primaryColorDark,
                    iconColor: Theme.of(context).primaryColorDark,
                    collapsedIconColor: Theme.of(context).primaryColorDark,
                    childrenPadding: const EdgeInsets.all(8),
                    expandedAlignment: Alignment.topLeft,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Main',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Wrap(
                        children: itemsProvider.getCategories().main.map((cat) {
                          bool iC = itemsProvider.mainFilter.contains(cat);
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(
                                    () => itemsProvider.setMainFilter(cat));
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(iC ? '$cat  ✔️' : cat),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Flavours',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Wrap(
                        children: itemsProvider.getCategories().sub.map((cat) {
                          bool iC = itemsProvider.subFilter.contains(cat);
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() => itemsProvider.setSubFilter(cat));
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(iC ? '$cat  ✔️' : cat),
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
