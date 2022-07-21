import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skip_q_lah/models/constants.dart';
import 'package:skip_q_lah/models/firestore/collections/item.dart';
import 'package:skip_q_lah/models/providers/order.dart';
import 'package:skip_q_lah/screens/main/outlet/order/success.dart';
import 'package:skip_q_lah/screens/main/outlet/change_location.dart';
import 'package:skip_q_lah/widgets/reusable_widgets.dart';

class ConfirmOrderPage extends StatefulWidget {
  const ConfirmOrderPage({Key? key}) : super(key: key);

  @override
  State<ConfirmOrderPage> createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CreateOrderProvider>(
      builder: (context, orderProvider, child) {
        double totalPrice = orderProvider.getTotalPrice();
        List<MapEntry<Item, int>> itemMapEntries =
            orderProvider.getItemMapEntries();

        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    24,
                    181,
                    24,
                    64,
                  ),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextSubHeader('Outlet'),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              orderProvider.outlet?.name ??
                                  'Lunar @ Unknown Place',
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: 'Change location',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ChangeOrderLocation(),
                                    ),
                                  );
                                },
                              style: const TextStyle(color: Colors.blueAccent),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const TextSubHeader('Items'),
                      ...itemMapEntries.map(
                        (mapEntry) {
                          Item item = mapEntry.key;
                          int count = mapEntry.value;

                          return ConfirmItemTile(
                            item: item,
                            provider: orderProvider,
                            count: count,
                          );
                        },
                      ),
                      const Divider(thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Sub Total'),
                          Text(
                            '\$${totalPrice.toStringAsFixed(2)}',
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('GST Inclusive - 7%'),
                          Text(
                            '\$${(totalPrice * 0.07).toStringAsFixed(2)}',
                          )
                        ],
                      ),
                      const Divider(thickness: 1),
                      Row(
                        children: [
                          const TextSubHeader('Total price'),
                          const Spacer(),
                          TextSubHeader(
                            '\$${totalPrice.toStringAsFixed(2)}',
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Material(
                  color: Theme.of(context).backgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 110,
                        padding:
                            const EdgeInsets.only(top: 34, left: 24, right: 24),
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.transparent,
                          child: IconButton(
                            splashRadius: 28,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.arrowLeft,
                              size: 24,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Confirm Order',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
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
                bottom: 0,
                left: 20,
                right: 20,
                child: ElevatedButton(
                  onPressed: orderProvider.items.isEmpty
                      ? null
                      : () {
                          orderProvider.pendOrder().then((value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return OrderDetails(userOrder: value);
                              }),
                            );
                          });
                        },
                  child: const Text('Check Out'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fixedSize: const Size(double.infinity, 50),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class ConfirmItemTile extends StatefulWidget {
  const ConfirmItemTile({
    Key? key,
    required this.item,
    required this.provider,
    required this.count,
  }) : super(key: key);

  final CreateOrderProvider provider;
  final Item item;
  final int count;

  @override
  State<ConfirmItemTile> createState() => _ConfirmItemTileState();
}

class _ConfirmItemTileState extends State<ConfirmItemTile> {
  late CreateOrderProvider provider;
  late Item item;
  late int count;

  @override
  Widget build(BuildContext context) {
    item = widget.item;
    provider = widget.provider;
    count = widget.count;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12)),
                child: Image.network(
                  item.displayImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${(item.price * count).toStringAsFixed(2)}',
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() => count++);
                      provider.addItem(item);
                    },
                    child: Center(
                      child: Text(
                        '+',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.cadetBlueCrayola.withAlpha(50),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(count.toString()),
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    onTap: () {
                      provider.removeItem(item);
                    },
                    child: Center(
                      child: Text(
                        '-',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
