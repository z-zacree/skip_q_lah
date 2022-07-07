import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_context/one_context.dart';
import 'package:skip_q_lah/models/constants.dart';

class ThemeMaterial extends StatelessWidget {
  const ThemeMaterial({
    Key? key,
    required this.initRoute,
    required this.routes,
  }) : super(key: key);

  final String initRoute;
  final Map<String, WidgetBuilder> routes;

  final List<ThemeMode> themeModes = const [
    ThemeMode.system,
    ThemeMode.light,
    ThemeMode.dark,
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('user_preferences').listenable(),
      builder: (BuildContext context, Box<dynamic> box, Widget? child) {
        var themeMode = box.get('theme_mode', defaultValue: 0);
        return MaterialApp(
          builder: OneContext().builder,
          debugShowCheckedModeBanner: false,
          theme: ThemeProvider.lightTheme,
          darkTheme: ThemeProvider.darkTheme,
          themeMode: themeModes[themeMode],
          initialRoute: initRoute,
          routes: routes,
        );
      },
    );
  }
}
