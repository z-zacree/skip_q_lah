import 'package:skip_q_lah/models/auth/main.dart';
import 'package:skip_q_lah/screens/main/main.dart';
import 'package:skip_q_lah/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _signInForm = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Form(
        key: _signInForm,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: screenHeight * 0.1,
            left: 36,
            right: 36,
            bottom: 36,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const TextHeader(),
              const Text(
                'No more waiting in queue! Order your food online now!',
              ),
              const SizedBox(height: 48),
              RoundedOutlineInput(
                label: 'Email',
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a valid Email';
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return 'Please enter a valid Email';
                  }
                  return null;
                },
                controller: email,
              ),
              const SizedBox(height: 20),
              RoundedOutlineInput(
                label: 'Password',
                validator: (String? value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.length < 8) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
                obscureText: true,
                controller: password,
              ),
              const SizedBox(height: 24),
              SecondaryButton(
                onPressed: () async {
                  if (_signInForm.currentState!.validate()) {
                    await AuthenticationService()
                        .emailSignIn(
                      email: email.text.trim(),
                      password: password.text.trim(),
                    )
                        .then((res) {
                      if (res['code'] == 'sign-in-success') {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const MainHomePage();
                          }),
                          (route) => false,
                        );
                      } else {
                        email.text = '';
                        password.text = '';
                        _signInForm.currentState!.validate();
                      }
                    });
                  }
                },
                child: const Text('Sign in'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
