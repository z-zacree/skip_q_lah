import 'package:flutter/material.dart';
import 'package:skip_q_lah/models/firestore/collections/order.dart';
import 'package:skip_q_lah/widgets/order/panel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({
    Key? key,
    required this.order,
    required this.callback,
  }) : super(key: key);

  final UserOrder order;
  final VoidCallback callback;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  late UserOrder userOrder;

  @override
  void initState() {
    userOrder = widget.order;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SlidingUpPanel(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            panelBuilder: (ScrollController scrollController) => OrderPanel(
              controller: scrollController,
              userOrder: userOrder,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(32, 56, 32, 112),
                  child: Text(
                    'Your order has been placed successfully!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Stack(
                  children: [
                    const Image(
                        image: AssetImage('assets/images/order_success.png')),
                    Positioned.fill(
                      child: Center(
                        child: Material(
                          color: Theme.of(context).primaryColor,
                          shape: const StadiumBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              '# ${userOrder.identityNumber}',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.only(bottom: 12),
              color: Theme.of(context).backgroundColor,
              child: ElevatedButton(
                onPressed: widget.callback,
                child: Text('Back to home'),
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// SlidingUpPanel(
//               maxHeight: MediaQuery.of(context).size.height * 0.6,
//               minHeight: 100,
//               color: Theme.of(context).backgroundColor,
//               borderRadius: const BorderRadius.vertical(
//                 top: Radius.circular(20),
//               ),
//               panelBuilder: (ScrollController scrollController) => OrderPanel(
//                 controller: scrollController,
//                 userOrder: userOrder,
//               ),
//             ),

// PrimaryButton(
//               onPressed: () {
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) {
//                     return const OutletListPage();
//                   }),
//                   (route) => false,
//                 );
//               },
//               child: const Text(
//                 'Back to menu',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//               ),
//             ),