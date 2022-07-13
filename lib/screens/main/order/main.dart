import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skip_q_lah/models/constants.dart';
import 'package:skip_q_lah/models/firestore/collections/item.dart';
import 'package:skip_q_lah/models/firestore/collections/order.dart';
import 'package:skip_q_lah/models/firestore/collections/outlet.dart';
import 'package:skip_q_lah/models/firestore/main.dart';
import 'package:skip_q_lah/widgets/reusable_widgets.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  Stream stream = FirestoreService().getUserOrders();

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
          StreamBuilder(
            stream: stream,
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
                        return Text(userOrder.orderNumber.toString());
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
