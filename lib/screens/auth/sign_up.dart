import 'package:flutter/material.dart';
import 'package:skip_q_lah/models/auth/main.dart';
import 'package:skip_q_lah/widgets/reusable_widgets.dart';

import 'additional_details.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _signUpForm = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Form(
        key: _signUpForm,
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
              RoundedOutlineInput(
                padding: const EdgeInsets.symmetric(vertical: 12),
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
              RoundedOutlineInput(
                label: 'Confirm Password',
                validator: (String? value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      password.text != confirmPassword.text) {
                    return 'Please enter the same password';
                  }
                  return null;
                },
                obscureText: true,
                controller: confirmPassword,
              ),
              const SizedBox(height: 24),
              SecondaryButton(
                onPressed: () async {
                  if (_signUpForm.currentState!.validate()) {
                    await AuthenticationService()
                        .emailSignUp(
                      email: email.text.trim(),
                      password: password.text.trim(),
                    )
                        .then((res) {
                      if (res['code'] == 'sign-up-success') {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const UserDetailsPage();
                          }),
                          (route) => false,
                        );
                      } else {
                        email.text = '';
                        password.text = '';
                        confirmPassword.text = '';
                        _signUpForm.currentState!.validate();
                      }
                    });
                  }
                },
                child: const Text('Sign up'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
