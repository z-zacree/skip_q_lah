import 'package:flutter/material.dart';
import 'package:skip_q_lah/screens/main/order/listing.dart';
import 'package:skip_q_lah/widgets/theme_material.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const ThemeMaterial(
      initPage: OrderListing(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
