import 'package:app_new/comando.dart';
import 'package:flutter/material.dart';
import 'package:app_new/mqttcommunication.dart';

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
                SizedBox(
                  height: 100.0,
                ),
                RaisedButton(
                  color: Colors.green[300],
                  onPressed: () {
                    connectClient().then((value) => null);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreent()));
                  },
                  child: const Text('Entrar', style: TextStyle(fontSize: 30)),
                ),
              ])),
        ));
  }
}
