// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, must_be_immutable, camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_master/class/user.dart';
import 'package:viewapp_master/modules/PreferencesUtil.dart';
import 'package:viewapp_master/pages/home.dart';
import 'package:viewapp_master/pages/widget/wallpaper.dart';

// 定義輸入元件
final TextEditingController serverSourceStr = TextEditingController();
final TextEditingController usernameStr = TextEditingController();
final TextEditingController passwordStr = TextEditingController();

const focusedcolor = Colors.green;
const enablecolor = Colors.black;

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: InputGet(),
    );
  }
}

class InputGet extends StatelessWidget {
  const InputGet({Key? key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          wallpaperLogin(),
          const SizedBox(height: 20.0),
          const LoginStr(),
          const SizedBox(height: 20.0),
          const btnView(),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}

class LoginStr extends StatelessWidget {
  const LoginStr({Key? key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        tbServerSource(),
        SizedBox(height: 10),
        tbUsername(),
        SizedBox(height: 10),
        tbPassword(),
      ],
    );
  }
}

class tbServerSource extends StatelessWidget {
  const tbServerSource({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: serverSourceStr,
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.info),
            labelText: "Server",
            hintText: "Your Server Address",
            enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: enablecolor)),
            focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: focusedcolor))),
      ),
    );
  }
}

class tbUsername extends StatelessWidget {
  const tbUsername({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: usernameStr,
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.person),
            labelText: "Username",
            hintText: "Your account username",
            enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: enablecolor)),
            focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: focusedcolor))),
      ),
    );
  }
}

class tbPassword extends StatelessWidget {
  const tbPassword({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: passwordStr,
        obscureText: true,
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.lock),
            labelText: "Password",
            hintText: "Your account password",
            enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: enablecolor)),
            focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: focusedcolor))),
      ),
    );
  }
}

class btnView extends StatelessWidget {
  const btnView({Key? key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 50.0),
                btnLoginSend(),
                SizedBox(width: 50.0)
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                btnToforgetPage(),
                SizedBox(width: 50.0),
                btnClear(),
              ],
            )
          ],
        ));
  }
}

class btnLoginSend extends StatelessWidget {
  const btnLoginSend({Key? key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.0,
      height: 100.0,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
        ),
        child: const Text("Login",
            style: TextStyle(color: Colors.black)
        ),
        onPressed: () {
          checkInputNull(context);
          sendUserData(context);
        },
      ),
    );
  }

  void checkInputNull(BuildContext context) {
    String? serverSource = serverSourceStr.text;
    String? username = usernameStr.text;
    String? password = passwordStr.text;

    if (serverSource == "" || username == "" || password == "") {
      showFailAlert(context);
    }
  }

  // 使用者比對部分
  Future<dynamic> sendUserData(BuildContext context) async {
    String? serverSource = serverSourceStr.text;
    String? username = usernameStr.text;
    String? password = passwordStr.text;

    final Uri uri = Uri.http(serverSource, "/auth/MasterLogin");
    final response = await http.post(uri, body: {
      "username": username,
      "password": password
    }, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    final result = response.body;
    final data = jsonDecode(result);
    final code = data["code"];
    final user = userData(
        serverSource: serverSourceStr.text,
        LoginName: data["LoginName"],
        username: data["username"]);

    /*主迴圈*/
    if (code == "1") {
      /*save Str in local*/
      PreferencesUtil.saveString('serverSource', serverSourceStr.text);
      PreferencesUtil.saveString('username', data["username"]);
      PreferencesUtil.saveString('LoginName', data["LoginName"]);
      //Go To HomePage
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              key: null,
              user: user,
            ),
          ));
    } else if (code == "0") {
      showFailPasswordAlert(context);
    } else if (code == "-1") {
      showFailCNAlert(context);
    }
  }

  //輸出註冊失敗
  Future<void> showFailAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Fail!'),
          content: const Text('Please check you are Input Data!'),
          backgroundColor: Colors.yellow,
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                pushToLogin(context);
              },
            ),
          ],
        );
      },
    );
  }

  //輸入密碼失敗
  Future<void> showFailPasswordAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Password Fail!'),
          content: const Text('Please check you are Password!'),
          backgroundColor: Colors.yellow,
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                pushToLogin(context);
              },
            ),
          ],
        );
      },
    );
  }

  //輸出登入失敗
  Future<void> showFailCNAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.yellow,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Network Connection Fail!'),
          content: const Text('Please check you are Network & Server!'),
          backgroundColor: Colors.yellow,
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK',
              ),
              onPressed: () {
                pushToLogin(context);
              },
            ),
          ],
        );
      },
    );
  }

  //跳回登入主頁
  void pushToLogin(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }
}

class btnClear extends StatelessWidget {
  const btnClear({Key? key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.0,
      height: 100.0,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
        ),
        child: const Text("Clear",
          style: TextStyle(color: Colors.black)
        ),
        onPressed: () {
          clearInput();
        },
      ),
    );
  }
  void clearInput() {
    serverSourceStr.text = "";
    usernameStr.text = "";
    passwordStr.text = "";
  }
}

class btnToforgetPage extends StatelessWidget {
  const btnToforgetPage({Key? key});

  //跳回登入主頁
  void pushToforget(BuildContext context) {
    Navigator.pushNamed(context, '/forget');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.0,
      height: 100.0,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
        ),
        child: const Text("Forget",
            style: TextStyle(color: Colors.black)
        ),
        onPressed: () {
          pushToforget(context);
        },
      ),
    );
  }
}
