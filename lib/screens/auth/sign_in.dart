import 'package:skip_q_lah/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _signInForm = GlobalKey<FormState>();

  void back() => Navigator.pop(context);

  void navigate(String? routeName) {
    Navigator.pushNamed(context, "/$routeName");
  }

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
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid Email';
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return 'Please enter a valid Email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              RoundedOutlineInput(
                label: 'Password',
                validator: (String? value) {
                  if (value == null || value.isEmpty || value.length < 8) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
                obscureText: true,
              ),
              const SizedBox(height: 24),
              SecondaryButton(
                onPressed: () {
                  if (_signInForm.currentState!.validate()) {
                    navigate('main');
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
