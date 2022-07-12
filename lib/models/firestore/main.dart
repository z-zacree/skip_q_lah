import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:skip_q_lah/models/constants.dart';
import 'package:skip_q_lah/models/firestore/collections/outlet.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class FirestoreService {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  String apiKey = 'AIzaSyBUM88YEOtsvTrRvahoyTL65U2coEWVHUs';

  Future<List<Outlet>> getOutletList() async {
    List<Outlet> outletList = [];

    QuerySnapshot<JsonResponse> qShot = await fs.collection("outlets").get();

    for (var doc in qShot.docs) {
      String placeID = doc.get('address')['place_id'];
      String url =
          'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeID&key=$apiKey';

      var response = await http.post(Uri.parse(url));
      var result = convert.jsonDecode(response.body);
      JsonResponse latLng = {
        'latitude': result['result']['geometry']['location']['lat'],
        'longtitude': result['result']['geometry']['location']['lng'],
      };
      outletList.add(Outlet.fromFire(doc.id, latLng, doc.data()));
    }
    return outletList;
  }

  Future<Outlet> getOutlet(DocumentReference<JsonResponse> outletRef) async {
    DocumentSnapshot<JsonResponse> outletDoc = await outletRef.get();

    String placeID = outletDoc.get('address')['place_id'];
    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeID&key=$apiKey';

    var response = await http.post(Uri.parse(url));
    var result = convert.jsonDecode(response.body);
    JsonResponse latLng = {
      'latitude': result['result']['geometry']['location']['lat'],
      'longtitude': result['result']['geometry']['location']['lng'],
    };

    return Outlet.fromFire(outletDoc.id, latLng, outletDoc.data()!);
  }

  void setUserDetails({
    required String uid,
    required JsonResponse data,
  }) {
    fs.collection('users').doc(uid).set(data);
  }
}
