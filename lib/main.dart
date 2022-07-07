import 'package:skip_q_lah/firebase_options.dart';
import 'package:skip_q_lah/models/providers/items.dart';
import 'package:skip_q_lah/models/providers/menu.dart';
import 'package:skip_q_lah/models/providers/user_details.dart';
import 'package:skip_q_lah/screens/auth/additional_details.dart';
import 'package:skip_q_lah/screens/auth/sign_in.dart';
import 'package:skip_q_lah/screens/auth/sign_up.dart';
import 'package:skip_q_lah/screens/auth/main.dart';
import 'package:skip_q_lah/screens/main/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skip_q_lah/widgets/theme_material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('user_preferences');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserDetailsProvider()),
        ChangeNotifierProvider.value(value: ItemsProvider()),
        ChangeNotifierProvider.value(value: MenuProvider()),
      ],
      child: ThemeMaterial(
        initRoute: '/auth',
        routes: {
          '/auth': (context) => const MainAuthPage(),
          '/signIn': (context) => const SignInPage(),
          '/signUp': (context) => const SignUpPage(),
          '/userDetails': (context) => const UserDetailsPage(),
          '/main': (context) => const MainHomePage(),
        },
      ),
    );
  }
}
