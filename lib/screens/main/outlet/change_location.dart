import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skip_q_lah/models/firestore/collections/outlet.dart';
import 'package:skip_q_lah/models/firestore/main.dart';
import 'package:skip_q_lah/models/providers/order.dart';
import 'package:skip_q_lah/widgets/reusable_widgets.dart';

class ChangeOrderLocation extends StatefulWidget {
  const ChangeOrderLocation({Key? key}) : super(key: key);

  @override
  State<ChangeOrderLocation> createState() => _ChangeOrderLocationState();
}

class _ChangeOrderLocationState extends State<ChangeOrderLocation> {
  late Future<List<Outlet>> futureList;

  @override
  void initState() {
    super.initState();
    futureList = FirestoreService().getOutletList();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Consumer<CreateOrderProvider>(
      builder: (context, prov, child) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () {
              return Future(
                () => setState(() {
                  futureList = FirestoreService().getOutletList();
                }),
              );
            },
            child: ListView(
              padding: EdgeInsets.only(
                top: screenHeight * 0.1,
                left: 36,
                right: 36,
              ),
              children: [
                const TextHeader(text: 'Outlets'),
                FutureBuilder(
                  future: futureList,
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<Outlet>> snapshot,
                  ) {
                    if (snapshot.hasError) {
                      return const Text(
                        'Data failed to load, make sure you\'re connected to the internet',
                        textAlign: TextAlign.center,
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
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
                    } else {
                      List<Outlet> outletList = snapshot.data!;

                      return SizedBox(
                        height: screenHeight * 0.9 - 123,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: outletList.length,
                          itemBuilder: (BuildContext context, int index) {
                            Outlet outlet = outletList[index];

                            return ChangeOutletTile(
                              outlet: outlet,
                              provider: prov,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 16);
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                futureList = FirestoreService().getOutletList();
              });
            },
            child: FaIcon(
              FontAwesomeIcons.arrowRotateRight,
              size: 18,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
        );
      },
    );
  }
}

class ChangeOutletTile extends StatelessWidget {
  const ChangeOutletTile(
      {Key? key, required this.outlet, required this.provider})
      : super(key: key);

  final Outlet outlet;
  final CreateOrderProvider provider;

  Widget isOutletAvailable(bool isOpen) {
    final Color color = isOpen ? Colors.green : Colors.red;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 8, right: 10, bottom: 2),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        Text(
          isOpen ? 'Open' : 'Closed',
          style: TextStyle(color: color),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.primary.withAlpha(20),
      contentPadding: const EdgeInsets.all(10),
      onTap: () {
        provider.changeOutlet(outlet);
        Navigator.pop(context);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      title: Text(
        outlet.name,
        overflow: TextOverflow.fade,
        maxLines: 1,
        softWrap: false,
      ),
      subtitle: isOutletAvailable(outlet.isOpen),
      leading: Container(
        width: 56,
        height: 56,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
        child: Image.network(
          outlet.displayImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
