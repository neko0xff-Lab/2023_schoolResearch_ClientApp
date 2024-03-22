// ignore_for_file: camel_case_types, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:viewapp_user/pages/btn/ctr/switchCtr.dart';
import 'package:viewapp_user/pages/btn/ctr/valueCtr.dart';
import 'package:viewapp_user/pages/widget/wallpaper.dart';

class Control extends StatelessWidget {
  const Control({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blue, backgroundColor: Colors.white),
        ),
        home: Scaffold(
          body: ControlPage(),
        ));
  }
}

class ControlPage extends StatelessWidget {
  const ControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
            child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 10.0),
        Text('控制單元',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        SizedBox(height: 10.0),
        btn1(),
        SizedBox(height: 10.0),
        btn2(),
        SizedBox(height: 5.0),
        wallpaperLogin(),
      ],
    )));
  }
}

class btn1 extends StatelessWidget {
  const btn1({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => switchCtrPage()));
        },
        style: ElevatedButton.styleFrom(minimumSize: const Size(150, 100)),
        child: Text('開關控制'));
  }
}

class btn2 extends StatelessWidget {
  const btn2({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => valueCtrPage()));
        },
        style: ElevatedButton.styleFrom(minimumSize: const Size(150, 100)),
        child: Text('使用者\n自訂值', textAlign: TextAlign.center));
  }
}
