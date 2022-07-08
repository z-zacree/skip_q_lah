import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skip_q_lah/models/providers/order.dart';

class ConfirmOrderPage extends StatefulWidget {
  const ConfirmOrderPage({Key? key}) : super(key: key);

  @override
  State<ConfirmOrderPage> createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) => const Scaffold(
        body: Center(
          child: Text('Confirm Order'),
        ),
      ),
    );
  }
}
