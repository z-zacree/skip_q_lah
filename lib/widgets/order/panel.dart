import 'package:flutter/material.dart';
import 'package:skip_q_lah/models/firestore/collections/order.dart';

class OrderPanel extends StatefulWidget {
  const OrderPanel({
    Key? key,
    required this.controller,
    required this.userOrder,
  }) : super(key: key);

  final ScrollController controller;
  final UserOrder userOrder;

  @override
  State<OrderPanel> createState() => _OrderPanelState();
}

class _OrderPanelState extends State<OrderPanel> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
