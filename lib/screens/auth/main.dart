import 'package:skip_q_lah/models/constants.dart';
import 'package:skip_q_lah/screens/auth/additional_details.dart';
import 'package:skip_q_lah/screens/auth/sign_in.dart';
import 'package:skip_q_lah/screens/auth/sign_up.dart';
import 'package:skip_q_lah/screens/main/main.dart';
import 'package:skip_q_lah/widgets/reusable_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class MainAuthPage extends StatefulWidget {
  const MainAuthPage({Key? key}) : super(key: key);

  @override
  State<MainAuthPage> createState() => _MainAuthPageState();
}

class _MainAuthPageState extends State<MainAuthPage> {
  FadeInController googleButton = FadeInController();
  FadeInController emailButton = FadeInController();
  FadeInController anonButton = FadeInController();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 400))
        .then((_) => googleButton.fadeIn());
    Future.delayed(const Duration(milliseconds: 500))
        .then((_) => emailButton.fadeIn());
    Future.delayed(const Duration(milliseconds: 550))
        .then((_) => anonButton.fadeIn());
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: screenHeight * 0.1,
          left: 36,
          right: 36,
          bottom: 36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FadeIn(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: TextHeader(),
            ),
            const FadeIn(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: Text(
                'No more waiting in queue! Order your food online now!',
              ),
            ),
            const SizedBox(height: 48),
            FadeIn(
              controller: googleButton,
              duration: const Duration(milliseconds: 400),
              child: ElevatedButton.icon(
                icon: Image.asset(
                  "assets/images/google-icon.png",
                  height: 16,
                ),
                label: const Text(
                  'Log in with Google',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const UserDetailsPage();
                  }),
                  (route) => false,
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                  primary: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            FadeIn(
              controller: emailButton,
              duration: const Duration(milliseconds: 400),
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.email,
                  size: 18,
                  color: Colors.black,
                ),
                label: const Text(
                  'Log in with Email',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => Navigator.push(
                  context,
                  SwipeablePageRoute(builder: (context) {
                    return const SignInPage();
                  }),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                  primary: AppColors.cadetBlueCrayola,
                ),
              ),
            ),
            const SizedBox(height: 20),
            FadeIn(
              controller: anonButton,
              duration: const Duration(milliseconds: 400),
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.person,
                  size: 18,
                ),
                label: Text(
                  'Continue anonymously',
                  style: TextStyle(color: Theme.of(context).primaryColorLight),
                ),
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const MainHomePage();
                  }),
                  (route) => false,
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ),
            const SizedBox(height: 32),
            FadeIn(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Haven\'t created an account? '),
                    TextSpan(
                      text: 'Sign up now!',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.push(
                              context,
                              SwipeablePageRoute(
                                builder: (context) {
                                  return const SignUpPage();
                                },
                              ),
                            ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
