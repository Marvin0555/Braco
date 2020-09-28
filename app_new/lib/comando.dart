import 'dart:convert';
import 'dart:ffi';

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
                Butoon('+10', motor1_soma),
                Text(i.toString()),
                Butoon('-10', motor1_sub),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Butoon('+10', motor2_soma),
                Text(j.toString()),
                Butoon('-10', motor2_sub),
              ],
            ),
          ],
        )));
  }

  Future<void> motor1_soma() async {
    setState(() {
      i = i + 9;
    });
    _motor01();
  }

  Future<void> motor1_sub() async {
    setState(() {
      i = i - 9;
    });
    _motor01();
  }

  Future<void> motor2_soma() async {
    setState(() {
      j = j + 9;
    });
    _motor02();
  }

  Future<void> motor2_sub() async {
    setState(() {
      j = j - 9;
    });
    _motor02();
  }
}

class Butoon extends StatefulWidget {
  @override
  final String textListe;
  final Function ddd;
  Butoon(this.textListe, this.ddd);

  @override
  _ButoonState createState() => _ButoonState();
}

class _ButoonState extends State<Butoon> {
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(3),
        child: RaisedButton(
          onPressed: () {
            widget.ddd();
          },
          child: Text(widget.textListe, style: TextStyle(fontSize: 20)),
        ));
  }
}

const _base = 'https://coco-1f532.firebaseio.com/';
Future<void> _motor01() async {
  final respone = await http.patch(
    "$_base/.json",
    body: json.encode({'moto1': i}),
  );
  final id = json.decode(respone.body)['name'];
  print(json.decode(respone.body));
}

Future<void> _motor02() async {
  final respone = await http.patch(
    "$_base/.json",
    body: json.encode({'moto2': j}),
  );
}
