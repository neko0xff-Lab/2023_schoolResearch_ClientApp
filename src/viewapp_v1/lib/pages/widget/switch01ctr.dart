// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, avoid_print
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_v1/modules/PreferencesUtil.dart';

class Switchctr extends StatefulWidget {
  const Switchctr({Key? key}) : super(key: key);

  @override
  _SwitchctrState createState() => _SwitchctrState();
}

class _SwitchctrState extends State<Switchctr> {
  bool? setfan1;
  bool? setfan2;
  bool _switchSelectedFan1 = false;
  bool _switchSelectedFan2 = false;
  String setboards = "Switch01";

  @override
  void initState() {
    super.initState();
    _getSwitchStatus();
  }

  void _getSwitchStatus() async {
    bool? fan1Status = await PreferencesUtil.getBool("fan1ctr");
    bool? fan2Status = await PreferencesUtil.getBool("fan2ctr");
    setState(() {
      _switchSelectedFan1 = fan1Status ?? false;
      _switchSelectedFan2 = fan2Status ?? false;
    });
  }

  void _connectToServer() async {
    /*連線部分*/
    final String? serverSource =
        await PreferencesUtil.getString("serverSource");
    String status_fan1 = _switchSelectedFan1 ? '1' : '0';
    String status_fan2 = _switchSelectedFan2 ? '1' : '0';
    var url_fan1 = Uri.parse(
        'http://$serverSource/switchCtr/$setboards/fan1?status=$status_fan1');
    var url_fan2 = Uri.parse(
        'http://$serverSource/switchCtr/$setboards/fan2?status=$status_fan2');

    /*送出封包*/
    try {
      //fan1
      var response_fan1 = await http.get(url_fan1);
      print('Response status: ${response_fan1.statusCode}');
      print('Response body: ${response_fan1.body}');
      //fan2
      var response_fan2 = await http.get(url_fan2);
      print('Response status: ${response_fan2.statusCode}');
      print('Response body: ${response_fan2.body}');
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Fan1ctr(
            switchSelectedFan1: _switchSelectedFan1,
            onChanged: (value) {
              setState(() {
                _switchSelectedFan1 = value;
                PreferencesUtil.saveBool("fan1ctr", value);
              });
              _connectToServer();
            },
          ),
          const SizedBox(height: 20),
          Fan2ctr(
            switchSelectedFan2: _switchSelectedFan2,
            onChanged: (value) {
              setState(() {
                _switchSelectedFan2 = value;
                PreferencesUtil.saveBool("fan2ctr", value);
              });
              _connectToServer();
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// Fan1 控制項
class Fan1ctr extends StatelessWidget {
  final bool switchSelectedFan1;
  final ValueChanged<bool> onChanged;

  const Fan1ctr({
    Key? key,
    required this.switchSelectedFan1,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text(
          "Fan1 ",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Switch(
          value: switchSelectedFan1,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

//Fan2 控制項
class Fan2ctr extends StatelessWidget {
  final bool switchSelectedFan2;
  final ValueChanged<bool> onChanged;

  const Fan2ctr({
    Key? key,
    required this.switchSelectedFan2,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text(
          "Fan2 ",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Switch(
          value: switchSelectedFan2,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
