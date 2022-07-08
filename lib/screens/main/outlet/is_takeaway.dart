import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skip_q_lah/models/firestore/collections/outlet.dart';
import 'package:skip_q_lah/models/providers/order.dart';
import 'package:skip_q_lah/screens/main/outlet/menu.dart';
import 'package:skip_q_lah/widgets/reusable_widgets.dart';

class IsTakeaway extends StatefulWidget {
  const IsTakeaway({Key? key}) : super(key: key);

  @override
  State<IsTakeaway> createState() => _IsTakeawayState();
}

class _IsTakeawayState extends State<IsTakeaway> {
  @override
  Widget build(BuildContext context) {
    final Outlet outlet = ModalRoute.of(context)!.settings.arguments as Outlet;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Consumer<OrderProvider>(
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
                      orderProvider.resetOrder();
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
              const TextHeader(),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: screenWidth * 0.35,
                    height: screenWidth * 0.35 / 4 * 5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        orderProvider.order.isTakeaway = true;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OutletMenu(outlet: outlet),
                          ),
                        );
                      },
                      child: const TextSubHeader('I\'m taking away!'),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.35,
                    height: screenWidth * 0.35 / 4 * 5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        orderProvider.order.isTakeaway = false;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OutletMenu(outlet: outlet),
                          ),
                        );
                      },
                      child: const TextSubHeader('I\'m eating in!'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
