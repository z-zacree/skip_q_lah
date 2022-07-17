import 'package:flutter/material.dart';
import 'package:skip_q_lah/models/firestore/collections/order.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({Key? key, required this.order}) : super(key: key);

  final UserOrder order;

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  late UserOrder order;

  @override
  Widget build(BuildContext context) {
    order = widget.order;
    return Scaffold(
      body: Container(),
    );
  }
}
