// ignore_for_file: non_constant_identifier_names,use_build_context_synchronously, camel_case_types, unrelated_type_equality_checks

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_master/pages/out/account.dart';


// 定義輸入元件
TextEditingController serverSourceStr = TextEditingController();
TextEditingController usernameStr = TextEditingController();
TextEditingController loginNameStr = TextEditingController();
TextEditingController EmailStr = TextEditingController();
TextEditingController passwordStr = TextEditingController();
TextEditingController ConfirmPasswordStr = TextEditingController();

var focusedcolor = Colors.yellow;
var enablecolor = Colors.black;

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: InputGet(),
      backgroundColor: Colors.white,
    );
  }
}

class InputGet extends StatelessWidget {
  const InputGet({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 5.0),
          RegisterStr(),
          SizedBox(height: 10.0),
          btnView(),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

class RegisterStr extends StatelessWidget {
  const RegisterStr({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text("Register",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        tbServerSource(),
        tbloginName(),
        tbEmail(),
        tbUsername(),
        tbPassword(),
        tbConfirmPassword(),
      ],
    );
  }
}

class tbEmail extends StatelessWidget {
  const tbEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: EmailStr,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.mail),
            labelText: "Email",
            hintText: "You are use a Email?",
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: enablecolor)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: focusedcolor))),
      ),
    );
  }
}

class tbServerSource extends StatelessWidget {
  const tbServerSource({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: serverSourceStr,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.info),
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
  const tbUsername({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: usernameStr,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person),
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

class tbloginName extends StatelessWidget {
  const tbloginName({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: loginNameStr,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person),
            labelText: "Login Name",
            hintText: "Your account use a NickName",
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: enablecolor)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: focusedcolor))),
      ),
    );
  }
}

class tbPassword extends StatelessWidget {
  const tbPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: passwordStr,
        obscureText: true,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock),
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

class tbConfirmPassword extends StatelessWidget {
  const tbConfirmPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: ConfirmPasswordStr,
        obscureText: true,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock),
            labelText: "Confirm Password",
            hintText: "Password Check",
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: enablecolor)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: focusedcolor))),
      ),
    );
  }
}

class btnView extends StatelessWidget {
  const btnView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //SizedBox(width: 20.0),
            btnRegisterSend(),
            SizedBox(width: 20.0),
            btnClear(),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(width: 20.0),
            btnGoBack(),
            SizedBox(width: 20.0),
          ],
        ),
      ],
    );
  }
}

class btnRegisterSend extends StatelessWidget {
  const btnRegisterSend({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.0,
      height: 100.0,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
        ),
        child: const Text("Register",
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
    String? loginName = loginNameStr.text;
    String? username = usernameStr.text;
    String? password = passwordStr.text;
    String? email = EmailStr.text;
    String? ConfirmPassword = ConfirmPasswordStr.text;

    if (serverSource == "" ||
        loginName == "" ||
        username == "" ||
        password == "" ||
        email == "" ||
        ConfirmPassword == "") {
      showFailAlert(context);
    }
  }

  // 使用者比對部分
  void sendUserData(BuildContext context) {
    String? password = passwordStr.text;
    String? ConfirmPassword = ConfirmPasswordStr.text;
    if (password != ConfirmPassword) {
      showFailPasswordAlert(context);
    } else {
      cnServer(context);
    }
  }

  Future<dynamic> cnServer(BuildContext context) async {
    String? serverSource = serverSourceStr.text;
    String? loginName = loginNameStr.text;
    String? username = usernameStr.text;
    String? password = passwordStr.text;
    String? email = EmailStr.text;

    final Uri uri = Uri.http(serverSource, "/auth/CreateUser");
    final response = await http.post(uri, body: {
      "username": username,
      "password": password,
      "LoginName": loginName,
      "email": email
    }, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    final result = response.body;
    final data = jsonDecode(result);

    if (data["code"] == "1") {
      showFinnshAlert(context);
    } else if (data["code"] == "0") {
      showFailAlert(context);
    } else {
      showFailCNAlert(context);
    }
  }

  //輸出成功註冊
  Future<void> showFinnshAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Register Finnish!'),
          content: const Text('Please Go to Login Page,You now can Login!'),
          backgroundColor: Colors.yellow,
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                //pushToRegister(context);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size(100, 80)),
              child: const Text('Go Back'),
            )
          ],
        );
      },
    );
  }

  //輸出註冊失敗
  Future<void> showFailAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Register Fail!'),
          content: const Text('Please check you are Input Data!'),
          backgroundColor: Colors.yellow,
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                //pushToRegister(context);
                Navigator.of(context).pop();
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
                //pushToRegister(context);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //連線失敗
  Future<void> showFailCNAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Network Connection Fail!'),
          content: const Text('Please check you are Network & Server!'),
          backgroundColor: Colors.yellow,
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                //pushToRegister(context);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  //跳回註冊主頁
  void pushToRegister(BuildContext context) {
    Navigator.pushNamed(context, '/register');
  }
}

class btnClear extends StatelessWidget {
  const btnClear({super.key});

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
    loginNameStr.text = "";
    EmailStr.text = "";
    usernameStr.text = "";
    passwordStr.text = "";
    ConfirmPasswordStr.text = "";
  }
}

class btnGoBack extends StatelessWidget {
  const btnGoBack({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.0,
      height: 100.0,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
        ),
        child: const Text('Go Back',
            style: TextStyle(color: Colors.black)
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const AccountData()));
        },

      ),
    );

  }
}
