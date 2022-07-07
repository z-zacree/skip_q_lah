import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:skip_q_lah/screens/main/home/main.dart';
import 'package:skip_q_lah/screens/main/order/main.dart';
import 'package:skip_q_lah/screens/main/outlet/main.dart';
import 'package:skip_q_lah/screens/main/profile/main.dart';
import 'package:skip_q_lah/screens/main/settings/main.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int pageIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: ((value) {
            setState(() => pageIndex = value);
          }),
          children: const [
            HomePage(),
            OutletListPage(),
            OrderListPage(),
            ProfilePage(),
            SettingsPage(),
          ],
        ),
        bottomNavigationBar: SalomonBottomBar(
          onTap: (int index) => _pageController.animateToPage(
            index,
            curve: Curves.easeInCubic,
            duration: const Duration(milliseconds: 400),
          ),
          currentIndex: pageIndex,
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home_rounded),
              title: const Text('Home'),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.place),
              title: const Text('Outlets'),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.fastfood),
              title: const Text('Orders'),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.person_rounded),
              title: const Text('Profile'),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.settings),
              title: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
