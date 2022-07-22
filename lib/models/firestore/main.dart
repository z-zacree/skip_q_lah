import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skip_q_lah/models/constants.dart';
import 'package:skip_q_lah/models/firestore/collections/item.dart';
import 'package:skip_q_lah/models/firestore/collections/order.dart';
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
      String placeID = doc.get('place_id');
      String url =
          'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeID&key=$apiKey';

      var response = await http.post(Uri.parse(url));
      var result = convert.jsonDecode(response.body);

      JsonResponse additionalData = {
        'id': doc.id,
        'location': {
          'latitude': result['result']['geometry']['location']['lat'],
          'longitude': result['result']['geometry']['location']['lng'],
        },
        'address': result['result']['formatted_address'],
      };

      outletList.add(Outlet.fromFire(additionalData, doc.data()));
    }
    return outletList;
  }

  Future<Outlet> getOutlet(DocumentReference<JsonResponse> outletRef) async {
    DocumentSnapshot<JsonResponse> doc = await outletRef.get();

    String placeID = doc.get('place_id');
    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeID&key=$apiKey';

    var response = await http.post(Uri.parse(url));
    var result = convert.jsonDecode(response.body);

    JsonResponse additionalData = {
      'id': doc.id,
      'location': {
        'latitude': result['result']['geometry']['location']['lat'],
        'longitude': result['result']['geometry']['location']['lng'],
      },
      'address': result['result']['formatted_address'],
    };

    return Outlet.fromFire(additionalData, doc.data()!);
  }

  void setUserDetails({required String uid, required JsonResponse data}) {
    fs.collection('users').doc(uid).set(data);
  }

  Future<UserOrder> getUserOrder(String id, JsonResponse json) async {
    Outlet outlet = await FirestoreService().getOutlet(json['outlet']);

    json.update('outlet', (value) => outlet.toJson());

    List<dynamic> eL = json['items'];

    List<DocumentReference<JsonResponse>> itemRefList =
        eL.map((e) => e as DocumentReference<JsonResponse>).toList();

    List<JsonResponse> itemList = [];

    for (DocumentReference<JsonResponse> itemRef in itemRefList) {
      DocumentSnapshot<JsonResponse> docSnap = await itemRef.get();
      Item item = Item.fromFire(docSnap.id, docSnap.data()!);

      itemList.add(item.toJson());
    }

    json.update('items', (value) => itemList);

    return UserOrder.fromFire(id, json);
  }

  Stream<DocumentSnapshot<JsonResponse>> getUserInfo() {
    return fs
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  Stream<QuerySnapshot<JsonResponse>> getUserOrders() => fs
      .collection('orders')
      .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  Stream<QuerySnapshot<JsonResponse>> getNews() =>
      fs.collection('news').snapshots();
}
