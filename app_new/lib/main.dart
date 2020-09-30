import 'dart:convert';

import 'package:app_new/comando.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'APP Iot'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controllerLogin = TextEditingController();
  static const _base = 'https://marcos-bb52f.firebaseio.com/';
  // ignore: unused_element
  Future<void> _incrementCounter() async {
    final respone = await http.patch(
      "$_base/users/-MII18GhE6d5jhRu6gVO.json",
      body: json.encode({'name': 'weqwyye', 'email': 'ryr'}),
    );

    // ignore: unused_local_variable
    final id = json.decode(respone.body)['name'];
    print(json.decode(respone.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
                style: TextStyle(fontSize: 24.0),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.people),
                ),
                controller: _controllerLogin),
          ),
          SizedBox(
            height: 100.0,
          ),
          RaisedButton(
            color: Colors.green[300],
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreent()));
            },
            child: const Text('Entrar', style: TextStyle(fontSize: 20)),
          ),
        ])));
  }
}
