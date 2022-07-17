import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:skip_q_lah/models/firestore/collections/outlet.dart';

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
