import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skip_q_lah/models/firestore/collections/order.dart';
import 'package:skip_q_lah/screens/main/order/details.dart';
import 'package:skip_q_lah/widgets/reusable_widgets.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({Key? key, required this.order}) : super(key: key);

  final UserOrder order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: TextSubHeader('Order #${order.identityNumber}'),
        subtitle: Text(
          order.orderModeAsString,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        trailing: FaIcon(
          FontAwesomeIcons.caretRight,
          color: Theme.of(context).primaryColorDark,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetails(
                order: order,
                callback: () => Navigator.pop(context),
              ),
            ),
          );
        },
      ),
    );
  }
}
