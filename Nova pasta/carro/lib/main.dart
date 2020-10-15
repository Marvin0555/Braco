import 'dart:convert';
import 'package:carro/mqttcommunication.dart';
import 'package:carro/comando.dart';
import 'package:flutter/material.dart';

String topico;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Carro IoT'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: Image.asset('images/ocean.png'),
                ),
                Selectbutton(Colors.blue, topic_pup1),
                Selectbutton(Colors.pink, topic_pup2),
                Selectbutton(Colors.orange, topic_pup3),
              ])),
        ));
  }
}

class Selectbutton extends StatelessWidget {
  MaterialColor cor;
  String pub_text;
  Selectbutton(this.cor, this.pub_text);
  Widget build(BuildContext context) {
    return RaisedButton(
      color: cor,
      child: Text(pub_text, style: TextStyle(fontSize: 25)),
      onPressed: () {
        connectClient().then((value) => topico = pub_text);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomeScreent()));
      },
    );
  }
}
