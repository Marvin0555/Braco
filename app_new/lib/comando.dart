import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

int i = 180;

class HomeScreen extends StatelessWidget {
  @override

  //String a = i.toString();

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
                RaisedButton(
                  onPressed: () {
                    i = i - 10;
                    _incrementCounter();
                  },
                  child: Text(i.toString(), style: TextStyle(fontSize: 20)),
                ),
                RaisedButton(
                  onPressed: () {
                    i = i + 10;
                    _incrementCounter();
                  },
                  child: Text(i.toString(), style: TextStyle(fontSize: 20)),
                )
              ],
            ),
            Butoon('w', aaa),
          ],
        )));
  }
}

class PatientRegisScreen {}

class LisTileInfo extends StatelessWidget {
  final IconData icone;
  final String textListe;
  final Widget screenDesired;
  LisTileInfo(this.icone, this.textListe, this.screenDesired);
  @override
  Widget build(BuildContext context) {
    //var icone2 = icone;
    return ListTile(
      leading: Icon(icone),
      title: Text(textListe),
      onTap: () {
        //gera eventos
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => screenDesired));
      },
    );
  }
}

class Butoon extends StatelessWidget {
  @override
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

Future<void> aaa() async {
  i = i - 9;
  _incrementCounter();
}

const _base = 'https://coco-1f532.firebaseio.com/';
Future<void> _incrementCounter() async {
  final respone = await http.patch(
    "$_base/.json",
    body: json.encode({'redlight': i}),
  );

  final id = json.decode(respone.body)['name'];
  print(json.decode(respone.body));
}
