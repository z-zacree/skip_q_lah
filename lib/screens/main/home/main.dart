import 'package:flutter/material.dart';
import 'package:skip_q_lah/models/auth/main.dart';
import 'package:skip_q_lah/screens/auth/main.dart';
import 'package:skip_q_lah/widgets/reusable_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: screenHeight * 0.1,
          left: 36,
          right: 36,
          bottom: 36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TextHeader(text: 'Home'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AuthenticationService().signOut();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainAuthPage()),
            (route) => false,
          );
        },
      ),
    );
  }
}
