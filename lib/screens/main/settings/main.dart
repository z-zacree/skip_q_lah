import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:skip_q_lah/models/constants.dart';
import 'package:skip_q_lah/widgets/reusable_widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void setTheme(String mode) {
    Box<dynamic> box = Hive.box('user_preferences');

    switch (mode) {
      case "light":
        box.put('theme_mode', 1);
        break;
      case "dark":
        box.put('theme_mode', 2);
        break;
      default:
        box.put('theme_mode', 0);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: screenHeight * 0.1,
        left: 36,
        right: 36,
        bottom: 36,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextHeader(text: 'Settings'),
          const Text('Edit application settings and preferences here!'),
          const SizedBox(height: 48),
          Container(),
          const TextSubHeader('Theme'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 100,
                height: 100,
                child: Card(
                  elevation: 0,
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: AppColors.oldLace,
                  child: InkWell(
                    splashColor: Colors.black38,
                    onTap: () => setTheme('light'),
                    child: const Icon(Icons.light_mode_outlined,
                        color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: Card(
                  elevation: 0,
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: AppColors.oxfordBlue,
                  child: InkWell(
                    splashColor: Colors.black38,
                    onTap: () => setTheme('dark'),
                    child: const Icon(
                      Icons.dark_mode_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: Card(
                  elevation: 0,
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: AppColors.cadetBlueCrayola,
                  child: InkWell(
                    splashColor: Colors.black38,
                    onTap: () => setTheme('auto'),
                    child: Icon(
                      Icons.auto_awesome_rounded,
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
