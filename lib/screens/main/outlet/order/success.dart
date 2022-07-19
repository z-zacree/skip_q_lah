import 'package:flutter/material.dart';
import 'package:skip_q_lah/models/firestore/collections/order.dart';
import 'package:skip_q_lah/screens/main/outlet/main.dart';
import 'package:skip_q_lah/widgets/reusable_widgets.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key, required this.userOrder}) : super(key: key);

  final UserOrder userOrder;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  late UserOrder userOrder;

  @override
  void initState() {
    userOrder = widget.userOrder;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: screenHeight * 0.1,
          left: 36,
          right: 36,
          bottom: 36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your order has been placed successfully!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Stack(
              children: [
                const Image(
                    image: AssetImage('assets/images/order_success.png')),
                Positioned.fill(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        '# ${userOrder.orderNumberString}',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            PrimaryButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const OutletListPage();
                  }),
                  (route) => false,
                );
              },
              child: const Text(
                'View details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
