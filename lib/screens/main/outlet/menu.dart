import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:skip_q_lah/models/constants.dart';
import 'package:skip_q_lah/models/firestore/collections/outlet.dart';
import 'package:skip_q_lah/models/providers/items.dart';
import 'package:skip_q_lah/widgets/reusable_widgets.dart';

class OutletMenu extends StatefulWidget {
  const OutletMenu({Key? key}) : super(key: key);

  @override
  State<OutletMenu> createState() => _OutletMenuState();
}

class _OutletMenuState extends State<OutletMenu> {
  late Map<String, List<OutletItem>> outletItems;

  @override
  Widget build(BuildContext context) {
    final Outlet outlet = ModalRoute.of(context)!.settings.arguments as Outlet;
    return Consumer<ItemsProvider>(
      builder: (
        BuildContext context,
        ItemsProvider itemsProvider,
        Widget? child,
      ) {
        outletItems = itemsProvider.getOutletItems(outlet);

        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 112,
                left: 32,
                right: 32,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextHeader(text: 'Menu'),
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
              ),
              Positioned(
                top: 48,
                left: 24,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
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
                  backgroundColor: Colors.transparent,
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
          ),
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
      const SizedBox(height: 8),
      ...itemList.map((outletItem) => Text(outletItem.item.name)).toList(),
      const SizedBox(height: 24)
    ],
  );
}

Widget buildFilterMenu(BuildContext context, ItemsProvider itemsProvider) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Material(
        color: Theme.of(context).backgroundColor,
        child: Padding(
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
                color: itemsProvider.filterCategories.isEmpty()
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
                      Row(
                        children: itemsProvider.getCategories().main.map((cat) {
                          bool iC =
                              itemsProvider.filterCategories.main.contains(cat);
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() => itemsProvider.setFilter(cat));
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
                      const Text(
                        'Flavours',
                        style: TextStyle(color: Colors.grey),
                      ),
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
