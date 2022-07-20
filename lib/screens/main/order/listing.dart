import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skip_q_lah/models/constants.dart';
import 'package:skip_q_lah/models/firestore/collections/order.dart';
import 'package:skip_q_lah/models/firestore/main.dart';
import 'package:skip_q_lah/widgets/order/tile.dart';
import 'package:skip_q_lah/widgets/reusable_widgets.dart';

class OrderListing extends StatefulWidget {
  const OrderListing({Key? key}) : super(key: key);

  @override
  State<OrderListing> createState() => _OrderListingState();
}

class _OrderListingState extends State<OrderListing> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: screenHeight * 0.1,
        left: 36,
        right: 36,
        bottom: 36,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextHeader(text: 'Orders'),
          const Text(
              'Show our staff your order number to collect your food 😊'),
          const SizedBox(height: 24),
          StreamBuilder<QuerySnapshot<JsonResponse>>(
            stream: FirestoreService().getUserOrders(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) return const Text('not connected');
              List<Widget> orderItemList = [];

              QuerySnapshot data = snapshot.data;

              for (var doc in data.docs) {
                JsonResponse json = doc.data() as JsonResponse;

                orderItemList.add(
                  FutureBuilder(
                    future: FirestoreService().getUserOrder(doc.id, json),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<UserOrder> snapshot,
                    ) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 300,
                          child: Center(
                            child: SpinKitThreeBounce(
                              color: Theme.of(context).primaryColorDark,
                              size: 25,
                            ),
                          ),
                        );
                      }

                      UserOrder userOrder = snapshot.data!;

                      if (userOrder.status != OrderStatus.completed) {
                        return OrderTile(order: userOrder);
                      }
                      return const SizedBox();
                    },
                  ),
                );
              }
              return Column(
                children: orderItemList,
              );
            },
          )
        ],
      ),
    );
  }
}
