import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

int i = 180;
int j = 180;

class HomeScreent extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Comandos'),
        ),
        body: Center(
            child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Butoon('+10', motor1Soma),
                Text(i.toString()),
                Butoon('-10', motor1Sub),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Butoon('+10', motor2Soma),
                Text(j.toString()),
                Butoon('-10', motor2Sub),
              ],
            ),
          ],
        )));
  }

  Future<void> motor1Soma() async {
    setState(() {
      i = i + 9;
    });
    _motor01();
  }

  Future<void> motor1Sub() async {
    setState(() {
      i = i - 9;
    });
    _motor01();
  }

  Future<void> motor2Soma() async {
    setState(() {
      j = j + 9;
    });
    _motor02();
  }

  Future<void> motor2Sub() async {
    setState(() {
      j = j - 9;
    });
    _motor02();
  }
}

class Butoon extends StatelessWidget {
  @override
  // ignore: override_on_non_overriding_member
  final String textListe;
  final Function ddd;
  Butoon(this.textListe, this.ddd);
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(3),
        child: RaisedButton(
          onPressed: () {
            ddd();
          },
          child: Text(textListe, style: TextStyle(fontSize: 20)),
        ));
  }
}

const _base = 'https://coco-1f532.firebaseio.com/';
Future<void> _motor01() async {
  final respone = await http.patch(
    "$_base/.json",
    body: json.encode({'moto1': i}),
  );
  // ignore: unused_local_variable
  // final id = json.decode(respone.body)['name'];
  //print(json.decode(respone.body));
}

Future<void> _motor02() async {
  // ignore: unused_local_variable
  final respone = await http.patch(
    "$_base/.json",
    body: json.encode({'moto2': j}),
  );
}
