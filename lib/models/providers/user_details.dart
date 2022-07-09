import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skip_q_lah/models/firestore/main.dart';

class UserDetailsProvider extends ChangeNotifier {
  String username = '';
  String fullName = '';
  String mobileNumber = '';
  int count = 0;

  void incCount() {
    count++;
    notifyListeners();
  }

  void decCount() {
    count--;
    notifyListeners();
  }

  void submitProcess({required Function callback}) {
    final user = <String, dynamic>{
      'username': username,
      'full name': fullName,
      'mobile number': mobileNumber,
    };

    FirestoreService().setUserDetails(
      data: user,
      uid: FirebaseAuth.instance.currentUser!.uid,
    );

    callback();
  }
}
