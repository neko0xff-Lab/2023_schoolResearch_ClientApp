import 'package:flutter/material.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:viewapp_v1_1/pages/out/about.dart';
import 'package:viewapp_v1_1/pages/user/forget.dart';
import 'package:viewapp_v1_1/pages/user/login.dart';
import 'package:viewapp_v1_1/pages/user/register.dart';
import 'package:viewapp_v1_1/pages/user/updateUser.dart';

void main() async {
  runApp(viewAppMain());
  /* localNotifier: Only Windows,Linux.macOS */
  await localNotifier.setup(
    appName: 'View App v1.1',
    shortcutPolicy:
        ShortcutPolicy.requireCreate, // shortcutPolicy: 仅适用于 Windows
  );
}

// ignore: use_key_in_widget_constructors, camel_case_types
class viewAppMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VisualDensity density = Theme.of(context).visualDensity;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "View App v1.1",
        theme:
            ThemeData(primarySwatch: Colors.blueGrey, visualDensity: density),
        home: const LoginPage(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/about': (context) => const AboutPage(),
          '/register': (context) => const RegisterPage(),
          '/forget': (context) => const forgetPage(),
          '/updateUser': (context) => const UpdateUserPage()
        });
  }
}
