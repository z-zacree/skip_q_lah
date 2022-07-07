import 'package:flutter/material.dart';

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
    // CFS cloudFirestore = CFS();

    final user = <String, dynamic>{
      'username': username,
      'full name': fullName,
      'mobile number': mobileNumber,
    };

    debugPrint(user.toString());

    // cloudFirestore.addUser(user);

    callback();
  }
}
