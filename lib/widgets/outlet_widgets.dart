import 'package:flutter/material.dart';
import 'package:skip_q_lah/models/firestore/collections/item.dart';
import 'package:skip_q_lah/models/firestore/collections/outlet.dart';
import 'package:skip_q_lah/models/providers/items.dart';
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
      onTap: () => Navigator.pushNamed(context, '/details', arguments: outlet),
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
  const ItemTile({Key? key, required this.isAvailable, required this.item})
      : super(key: key);

  final Item item;
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        dense: true,
        tileColor: Theme.of(context).colorScheme.primary.withAlpha(20),
        contentPadding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
        onTap: () {},
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
        trailing: Text(item.getPrice()),
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
      ),
    );
  }
}
