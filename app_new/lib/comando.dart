import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

int i = 180;
int j = 180;
int k = 180;
int l = 180;
int m = 180;
const _base = 'https://coco-1f532.firebaseio.com/';

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Butoon('+10', motor3Soma),
                      Text(k.toString()),
                      Butoon('-10', motor3Sub),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Butoon('+10', motor4Soma),
                      Text(l.toString()),
                      Butoon('-10', motor4Sub),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Butoon('+10', motor5Soma),
                  Text(m.toString()),
                  Butoon('-10', motor5Sub),
                ],
              ),
            ],
          ),
        ));
  }

  Future<void> motor1Soma() async {
    setState(() {
      if (i < 180) {
        i = i + 10;
        _motor01();
      }
    });
  }

  Future<void> motor1Sub() async {
    setState(() {
      if (i > 0) {
        i = i - 10;
        _motor01();
      }
    });
  }

  Future<void> motor2Soma() async {
    setState(() {
      if (j < 180) {
        j = j + 10;
        _motor02();
      }
    });
  }

  Future<void> motor2Sub() async {
    setState(() {
      if (j > 0) {
        j = j - 10;
        _motor02();
      }
    });
  }

  Future<void> motor3Soma() async {
    setState(() {
      if (k < 180) {
        k = k + 10;
        _motor03();
      }
    });
  }

  Future<void> motor3Sub() async {
    setState(() {
      if (k > 0) {
        k = k - 10;
        _motor03();
      }
    });
  }

  Future<void> motor4Soma() async {
    setState(() {
      if (l < 180) {
        l = l + 10;
        _motor04();
      }
    });
  }

  Future<void> motor4Sub() async {
    setState(() {
      if (l > 0) {
        l = l - 10;
        _motor04();
      }
    });
  }

  Future<void> motor5Soma() async {
    setState(() {
      if (m < 180) {
        m = m + 10;
        _motor05();
      }
    });
  }

  Future<void> motor5Sub() async {
    setState(() {
      if (m > 0) {
        m = m - 10;
        _motor05();
      }
    });
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
        padding: const EdgeInsets.all(2),
        child: RaisedButton(
          //color: Colors.green[300],
          highlightColor: Colors.red,
          //animationDuration: Duration(seconds: 2),
          onHighlightChanged: (valor) {
            print(valor);
          },
          onPressed: () {},
          child: Text(textListe, style: TextStyle(fontSize: 20)),
        ));
  }
}

Future<void> _motor01() async {
  final respone = await http.patch(
    "$_base/.json",
    body: json.encode({'moto1': i}),
  );
}

Future<void> _motor02() async {
  // ignore: unused_local_variable
  final respone = await http.patch(
    "$_base/.json",
    body: json.encode({'moto2': j}),
  );
}

Future<void> _motor03() async {
  // ignore: unused_local_variable
  final respone = await http.patch(
    "$_base/.json",
    body: json.encode({'moto3': k}),
  );
}

Future<void> _motor04() async {
  // ignore: unused_local_variable
  final respone = await http.patch(
    "$_base/.json",
    body: json.encode({'moto4': l}),
  );
}

Future<void> _motor05() async {
  // ignore: unused_local_variable
  final respone = await http.patch(
    "$_base/.json",
    body: json.encode({'moto5': m}),
  );
}
