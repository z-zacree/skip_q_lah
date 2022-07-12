import 'package:flutter/material.dart';
import 'package:skip_q_lah/widgets/reusable_widgets.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: screenHeight * 0.1,
          left: 36,
          right: 36,
          bottom: 36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TextHeader(text: 'Orders'),
          ],
        ),
      ),
    );
  }
}
