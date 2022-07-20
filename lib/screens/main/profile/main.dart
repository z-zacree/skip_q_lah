import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skip_q_lah/models/auth/main.dart';
import 'package:skip_q_lah/models/auth/user.dart';
import 'package:skip_q_lah/models/constants.dart';
import 'package:skip_q_lah/models/firestore/main.dart';
import 'package:skip_q_lah/screens/auth/main.dart';
import 'package:skip_q_lah/widgets/reusable_widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController unC = TextEditingController();
  TextEditingController fnC = TextEditingController();
  TextEditingController mnC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirestoreService().getUserInfo(),
      builder: (
        context,
        AsyncSnapshot<DocumentSnapshot<JsonResponse>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.active) {
          User currentUser = FirebaseAuth.instance.currentUser!;
          final String uid = currentUser.uid;
          final bool isAnon = currentUser.isAnonymous;

          DocumentSnapshot<JsonResponse> userDoc = snapshot.data!;

          UserData userData = UserData.fromFire(uid, isAnon, userDoc.data()!);
          unC.text = userData.username;
          fnC.text = userData.fullName;
          mnC.text = userData.mobileNumber;

          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 16, bottom: 32),
                      width: 48,
                      height: 4.5,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 2),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black)),
                    ),
                    child: const TextSubHeader('My Profile'),
                  ),
                  const SizedBox(height: 24),
                  RoundedOutlineInput(
                    padding: const EdgeInsets.only(bottom: 18),
                    controller: unC,
                    label: 'Username',
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          value.length > 64) {
                        return 'Please enter a valid username';
                      }
                      return null;
                    },
                    enabled: !userData.isAnon,
                  ),
                  RoundedOutlineInput(
                    padding: const EdgeInsets.only(bottom: 18),
                    controller: fnC,
                    label: 'Full Name',
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          value.length > 64) {
                        return 'Please enter a valid full name';
                      }
                      return null;
                    },
                  ),
                  RoundedOutlineInput(
                    padding: const EdgeInsets.only(bottom: 18),
                    controller: mnC,
                    label: 'Mobile Number',
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          value.length < 8 ||
                          value.length > 15 ||
                          double.tryParse(value) != null) {
                        return 'Please enter a valid mobile number';
                      }
                      return null;
                    },
                  ),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: unC,
                    builder: (context, username, child) =>
                        ValueListenableBuilder<TextEditingValue>(
                      valueListenable: fnC,
                      builder: (context, fullName, child) =>
                          ValueListenableBuilder<TextEditingValue>(
                        valueListenable: mnC,
                        builder: (context, mobileNumber, child) {
                          bool unCheck = username.text == userData.username;
                          bool fnCheck = fullName.text == userData.fullName;
                          bool mnCheck =
                              mobileNumber.text == userData.mobileNumber;

                          return PrimaryButton(
                            onPressed: unCheck && fnCheck && mnCheck
                                ? null
                                : () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    final user = <String, dynamic>{
                                      'username': username.text,
                                      'full_name': fullName.text,
                                      'mobile_number': mobileNumber.text,
                                    };

                                    FirestoreService().setUserDetails(
                                      data: user,
                                      uid: userData.uid,
                                    );
                                  },
                            child: const Text('Save changes'),
                          );
                        },
                      ),
                    ),
                  ),
                  const Divider(
                      height: 32, indent: 8, endIndent: 8, thickness: 1),
                  ElevatedButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text(
                          'Are you sure?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: const Text(
                          'Clicking on confirm will log you out of your account',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        actions: [
                          ButtonBar(
                            children: [
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  AuthenticationService().signOut();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return const MainAuthPage();
                                    }),
                                    (route) => false,
                                  );
                                },
                                child: const Text('Confirm'),
                              )
                            ],
                          )
                        ],
                        backgroundColor: Theme.of(context).backgroundColor,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      minimumSize: const Size(double.infinity, 45),
                      primary: Colors.red,
                    ),
                    child: const Text(
                      'Sign out',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Center(
          child: SpinKitChasingDots(
            color: Theme.of(context).primaryColorDark,
          ),
        );
      },
    );
  }
}
