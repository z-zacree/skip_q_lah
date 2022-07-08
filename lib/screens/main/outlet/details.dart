import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skip_q_lah/models/firestore/collections/outlet.dart';
import 'package:skip_q_lah/models/providers/order.dart';
import 'package:skip_q_lah/screens/main/outlet/menu.dart';
import 'package:skip_q_lah/widgets/outlet_widgets.dart';
import 'package:skip_q_lah/widgets/reusable_widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OutletDetail extends StatefulWidget {
  const OutletDetail({Key? key}) : super(key: key);

  @override
  State<OutletDetail> createState() => _OutletDetailState();
}

class _OutletDetailState extends State<OutletDetail> {
  @override
  Widget build(BuildContext context) {
    final Outlet outlet = ModalRoute.of(context)!.settings.arguments as Outlet;

    return Consumer<OrderProvider>(
      builder: (
        BuildContext context,
        OrderProvider orderProvider,
        Widget? child,
      ) {
        return Scaffold(
          body: Stack(
            children: [
              SlidingUpPanel(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
                minHeight: 100,
                parallaxEnabled: true,
                parallaxOffset: 0.55,
                color: Theme.of(context).backgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                panelBuilder: (ScrollController scrollController) =>
                    PanelWidget(
                  scrollController: scrollController,
                  outlet: outlet,
                ),
                body: MapWidget(outlet: outlet),
              ),
              Positioned(
                bottom: 0,
                left: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 12),
                  color: Theme.of(context).backgroundColor,
                  child: ElevatedButton(
                    onPressed: outlet.isOpen()
                        ? () {
                            orderProvider.order.outletId = outlet.id;
                            Navigator.pushNamed(
                              context,
                              '/isTakeaway',
                              arguments: outlet,
                            );
                          }
                        : null,
                    child: Text(outlet.isOpen() ? 'Order Here' : 'Closed'),
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 24,
                top: 48,
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: Theme.of(context).backgroundColor,
                  child: IconButton(
                    splashRadius: 28,
                    onPressed: () => Navigator.pop(context),
                    icon: FaIcon(
                      FontAwesomeIcons.arrowLeft,
                      size: 18,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key, required this.outlet}) : super(key: key);

  final Outlet outlet;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: outlet.latLng,
        zoom: 18,
        tilt: 30,
      ),
      markers: {
        Marker(
          markerId: MarkerId(outlet.name),
          position: outlet.latLng,
        )
      },
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      compassEnabled: true,
      onMapCreated: (controller) {
        Future.delayed(const Duration(seconds: 1)).then(
          (_) {
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  bearing: 45,
                  target: outlet.latLng,
                  tilt: 45.0,
                  zoom: 18,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class PanelWidget extends StatelessWidget {
  const PanelWidget({
    Key? key,
    required this.scrollController,
    required this.outlet,
  }) : super(key: key);

  final ScrollController scrollController;
  final Outlet outlet;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.only(
            left: 32,
            right: 32,
            bottom: 62,
          ),
          physics: const BouncingScrollPhysics(),
          controller: scrollController,
          children: <Widget>[
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 18),
                width: 48,
                height: 4.5,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            TextHeader(text: outlet.name),
            panelText(header: 'Description', body: outlet.description),
            const SizedBox(height: 24),
            panelText(
              header: 'Address',
              body: '''
${outlet.address.main}, ${outlet.address.sub}
${outlet.address.postalCode}''',
            ),
            const SizedBox(height: 24),
            panelText(header: 'Contact', body: outlet.contactNumber),
            const SizedBox(height: 24),
            const TextSubHeader('Opening Hours'),
            const SizedBox(height: 8),
            ...outlet.openingHours.asMap().entries.map((
              MapEntry<int, Period> periodEntry,
            ) {
              Period period = periodEntry.value;
              String day = days[periodEntry.key];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      SizedBox(
                        width: 64,
                        child: Text(day),
                      ),
                      Text('${period.open.time} - ${period.close.time}')
                    ],
                  ),
                ],
              );
            }),
            const SizedBox(height: 24),
          ],
        ),
        indicator(outlet),
      ],
    );
  }
}

List<String> days = ['Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat', 'Sun'];
