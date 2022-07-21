import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skip_q_lah/models/enums.dart';
import 'package:skip_q_lah/models/firestore/collections/outlet.dart';
import 'package:skip_q_lah/models/providers/order.dart';
import 'package:skip_q_lah/screens/main/outlet/order/menu.dart';
import 'package:skip_q_lah/widgets/reusable_widgets.dart';

class IsTakeaway extends StatefulWidget {
  const IsTakeaway({Key? key, required this.outlet}) : super(key: key);

  final Outlet outlet;

  @override
  State<IsTakeaway> createState() => _IsTakeawayState();
}

class _IsTakeawayState extends State<IsTakeaway> {
  late Outlet outlet;

  @override
  Widget build(BuildContext context) {
    outlet = widget.outlet;

    return Consumer<CreateOrderProvider>(
      builder: (context, orderProvider, child) => Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 110,
                padding: const EdgeInsets.only(top: 34),
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
                      size: 18,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
              ),
              TextHeader(text: outlet.name),
              const SizedBox(height: 24),
              ListTile(
                contentPadding: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                leading: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.asset('assets/images/takeaway.png'),
                ),
                title: const TextSubHeader('Takeaway'),
                enabled: outlet.takeawayType != ServiceType.notAvailable,
                onTap: () {
                  orderProvider.mode = OrderMode.takeaway;
                  orderProvider.type = outlet.takeawayType;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OutletMenu(outlet: outlet),
                    ),
                  );
                },
              ),
              const Divider(
                indent: 16,
                endIndent: 16,
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                leading: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.asset('assets/images/eating_in.png'),
                ),
                title: const TextSubHeader('Eating in'),
                enabled: outlet.eatingInType != ServiceType.notAvailable,
                onTap: () {
                  orderProvider.mode = OrderMode.eatingIn;
                  orderProvider.type = outlet.eatingInType;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OutletMenu(outlet: outlet),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
