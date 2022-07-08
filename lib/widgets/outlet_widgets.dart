import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:skip_q_lah/models/constants.dart';
import 'package:skip_q_lah/models/firestore/collections/item.dart';
import 'package:skip_q_lah/models/firestore/collections/outlet.dart';
import 'package:skip_q_lah/models/providers/order.dart';
import 'package:skip_q_lah/screens/main/outlet/details.dart';
import 'package:skip_q_lah/widgets/reusable_widgets.dart';

class OutletTile extends StatelessWidget {
  const OutletTile({Key? key, required this.outlet}) : super(key: key);

  final Outlet outlet;

  Widget isOutletAvailable(bool isOpen) {
    final Color color = isOpen ? Colors.green : Colors.red;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 8, right: 10, bottom: 2),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        Text(
          isOpen ? 'Open' : 'Closed',
          style: TextStyle(color: color),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.primary.withAlpha(20),
      contentPadding: const EdgeInsets.all(10),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return OutletDetail(outlet: outlet);
        }),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      title: Text(
        outlet.name,
        overflow: TextOverflow.fade,
        maxLines: 1,
        softWrap: false,
      ),
      subtitle: isOutletAvailable(outlet.isOpen()),
      leading: Container(
        width: 56,
        height: 56,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
        child: Image.network(
          outlet.displayImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

Widget panelText({required String header, required String body}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextSubHeader(header),
      const SizedBox(height: 8),
      Text(body),
    ],
  );
}

Widget indicator(Outlet outlet) {
  return Positioned(
    top: 18,
    right: 12,
    child: Container(
      margin: const EdgeInsets.only(left: 8, right: 10, bottom: 2),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: outlet.isOpen() ? Colors.green : Colors.red,
        shape: BoxShape.circle,
      ),
    ),
  );
}

class ItemTile extends StatelessWidget {
  const ItemTile({
    Key? key,
    required this.isAvailable,
    required this.item,
  }) : super(key: key);

  final Item item;
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        dense: true,
        enabled: isAvailable,
        tileColor: Theme.of(context).colorScheme.primary.withAlpha(20),
        contentPadding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
        onTap: isAvailable
            ? () => showCustomModalBottomSheet(
                  context: context,
                  builder: (context) => ItemDetails(item: item),
                  containerWidget: (context, animation, child) {
                    return SafeArea(
                      child: Material(
                        color: Colors.transparent,
                        clipBehavior: Clip.antiAlias,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: child,
                      ),
                    );
                  },
                )
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          item.name,
          overflow: TextOverflow.fade,
          maxLines: 1,
          softWrap: false,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          item.categories.sub.join(', '),
          maxLines: 1,
          overflow: TextOverflow.fade,
          softWrap: false,
        ),
        leading: Container(
          width: 48,
          height: 48,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Image.network(
            item.displayImage,
            fit: BoxFit.cover,
          ),
        ),
        trailing: Text(item.getPrice()),
      ),
    );
  }
}

class ItemDetails extends StatefulWidget {
  const ItemDetails({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  int count = 1;
  late Item item;

  void incCount() => setState(() => count++);
  void decCount() => count > 1 ? setState(() => count--) : null;

  @override
  Widget build(BuildContext context) {
    item = widget.item;
    return Consumer<OrderProvider>(
      builder: (
        BuildContext context,
        OrderProvider orderProvider,
        Widget? child,
      ) {
        return Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Stack(
            children: [
              ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(32, 32, 32, 82),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.network(item.displayImage),
                  ),
                  const SizedBox(height: 12),
                  TextHeader(text: item.name),
                  Text(
                    'Flavours: ' + item.categories.sub.join(', '),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 0,
                left: 24,
                right: 24,
                child: Container(
                  color: Theme.of(context).backgroundColor,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          TextSubHeader(item.getPrice()),
                          const Spacer(),
                          SizedBox(
                            width: 32,
                            height: 32,
                            child: ElevatedButton(
                              onPressed: decCount,
                              child: const Text(
                                '-',
                                textAlign: TextAlign.center,
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            width: 64,
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppColors.cadetBlueCrayola.withAlpha(50),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(count.toString()),
                            ),
                          ),
                          SizedBox(
                            width: 32,
                            height: 32,
                            child: ElevatedButton(
                              onPressed: incCount,
                              child: const Text(
                                '+',
                                textAlign: TextAlign.center,
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          orderProvider.addItemCount(item, count);
                          Navigator.pop(context);
                        },
                        child: const Text('Add to Cart'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          fixedSize:
                              Size(MediaQuery.of(context).size.width - 48, 50),
                        ),
                      ),
                    ],
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
