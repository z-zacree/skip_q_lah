import 'package:skip_q_lah/models/providers/user_details.dart';
import 'package:skip_q_lah/screens/main/main.dart';
import 'package:skip_q_lah/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({Key? key}) : super(key: key);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  int index = 0;
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _mobileNumController = TextEditingController();

  String nnDisplay = 'Skip';
  String fnDisplay = 'Skip';

  void navigateToMain() => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) {
          return const MainHomePage();
        }),
        (route) => false,
      );

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Consumer<UserDetailsProvider>(
      builder: (
        BuildContext context,
        UserDetailsProvider provider,
        Widget? child,
      ) {
        _nicknameController.addListener(() {
          provider.username = _nicknameController.text;
          if (_nicknameController.text.isEmpty) {
            setState(() => nnDisplay = 'Skip');
          } else {
            setState(() => nnDisplay = 'Continue');
          }
        });
        _fullNameController.addListener(() {
          provider.fullName = _fullNameController.text;
          if (_fullNameController.text.isEmpty) {
            setState(() => fnDisplay = 'Skip');
          } else {
            setState(() => fnDisplay = 'Continue');
          }
        });
        _mobileNumController.addListener(() {
          provider.mobileNumber = _mobileNumController.text;
        });
        return Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 36,
              vertical: screenHeight * 0.1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextHeader(),
                const Text(
                  'Next up, a few questions to let us know you better.',
                ),
                const SizedBox(height: 48),
                IndexedStack(
                  index: index,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        buildFormField(
                          controller: _nicknameController,
                          themeColor: Theme.of(context).primaryColorDark,
                          labelText: 'What would you like to be called?',
                          hintText: 'Give us your most creative nickname!',
                        ),
                        const SizedBox(height: 24),
                        PrimaryButton(
                          onPressed: () => setState(() => index++),
                          child: Text(nnDisplay),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        buildFormField(
                          controller: _fullNameController,
                          themeColor: Theme.of(context).primaryColorDark,
                          labelText: 'What is your full name?',
                          hintText: 'Of course, if you don\'t mind',
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: SecondaryButton(
                                onPressed: () => setState(() => index--),
                                child: const Text('Back'),
                              ),
                            ),
                            const SizedBox(width: 40),
                            Expanded(
                              child: PrimaryButton(
                                onPressed: () => setState(() => index++),
                                child: Text(fnDisplay),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        buildFormField(
                            controller: _mobileNumController,
                            themeColor: Theme.of(context).primaryColorDark,
                            labelText: 'What is your mobile number?',
                            hintText: 'Of course, if you don\'t mind',
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value.length < 8 ||
                                  value.length > 15 ||
                                  double.tryParse(value) != null) {
                                return 'Please enter a valid mobile number';
                              }
                              return null;
                            }),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: SecondaryButton(
                                onPressed: () => setState(() => index--),
                                child: const Text('Back'),
                              ),
                            ),
                            const SizedBox(width: 40),
                            Expanded(
                              child: PrimaryButton(
                                onPressed: () => provider.submitProcess(
                                  callback: navigateToMain,
                                ),
                                child: const Text('Finish'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

TextFormField buildFormField({
  required TextEditingController controller,
  required Color themeColor,
  required String labelText,
  String? hintText,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      labelText: labelText,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: themeColor,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: themeColor,
        ),
      ),
    ),
    validator: validator,
  );
}
