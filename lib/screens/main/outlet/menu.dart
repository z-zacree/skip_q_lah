import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:skip_q_lah/models/constants.dart';
import 'package:skip_q_lah/models/firestore/collections/item.dart';
import 'package:skip_q_lah/models/firestore/collections/outlet.dart';
import 'package:skip_q_lah/models/providers/items.dart';
import 'package:skip_q_lah/models/providers/order.dart';
import 'package:skip_q_lah/screens/main/order/confirm.dart';
import 'package:skip_q_lah/screens/main/outlet/main.dart';
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
    return Consumer2<ItemsProvider, OrderProvider>(
      builder: (
        BuildContext context,
        ItemsProvider itemsProvider,
        OrderProvider orderProvider,
        Widget? child,
      ) {
        outletItems = itemsProvider.getOutletItems(widget.outlet);

        return Stack(
          children: [
            Positioned.fill(
              child: ListView(
                padding: EdgeInsets.fromLTRB(
                  24,
                  169,
                  24,
                  orderProvider.order.itemList.isEmpty ? 0 : 32,
                ),
                physics: const BouncingScrollPhysics(),
                children: [
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
              top: 0,
              left: 24,
              right: 24,
              child: Container(
                height: 153,
                color: Theme.of(context).backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 110,
                      padding: const EdgeInsets.only(top: 34),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.transparent,
                            child: IconButton(
                              splashRadius: 28,
                              onPressed: () {
                                orderProvider.resetOrder();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return const OutletListPage();
                                  }),
                                  (route) => false,
                                );
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.xmark,
                                size: 24,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ),
                          const Spacer(),
                          CircleAvatar(
                            radius: 24,
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
                          )
                        ],
                      ),
                    ),
                    const Text(
                      'Menu',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Divider(
                      thickness: 1,
                      height: 0,
                      indent: 16,
                      endIndent: 16,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: orderProvider.order.itemList.isNotEmpty ? 0 : -50,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) {
                      return const ConfirmOrderPage();
                    }),
                  ),
                ),
                child: const Text('Confirm Order'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  fixedSize: const Size(double.infinity, 50),
                ),
              ),
            )
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
                    : Theme.of(context).colorScheme.primary.withAlpha(20),
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
