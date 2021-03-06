import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skip_q_lah/models/firestore/collections/outlet.dart';
import 'package:skip_q_lah/models/firestore/main.dart';
import 'package:skip_q_lah/widgets/outlet/tile.dart';
import 'package:skip_q_lah/widgets/reusable_widgets.dart';

class OutletListing extends StatefulWidget {
  const OutletListing({Key? key}) : super(key: key);

  @override
  State<OutletListing> createState() => _OutletListingState();
}

class _OutletListingState extends State<OutletListing> {
  late Future<List<Outlet>> futureList;

  @override
  void initState() {
    futureList = FirestoreService().getOutletList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
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
            const Text('Find out more about our outlets!'),
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

                        return OutletTile(outlet: outlet);
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
  }
}
