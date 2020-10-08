import 'package:carro/mqttcommunication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

int i = 22;
int j = 0;
int k = 0;
int l = 0;
int m = 0;
const _base = 'https://coco-1f532.firebaseio.com/';

class HomeScreent extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreent> {
  @override
  Widget build(BuildContext context) {
    //sublishLocation(topic_sub1);
    return Scaffold(
      appBar: AppBar(
        title: Text('Comandos'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/carocean1.png'),
              SizedBox(
                height: 150.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Butoon(Icons.arrow_back, 3),
                  Column(
                    children: [
                      Butoon(Icons.arrow_upward, 1),
                      Butoon(Icons.arrow_downward, 4),
                    ],
                  ),
                  Butoon(Icons.arrow_forward, 2),
                ],
              ),
            ],
          ),
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Butoon extends StatelessWidget {
  @override
  // ignore: override_on_non_overriding_member
  final IconData icon;
  int directionValue;
  Butoon(this.icon, this.directionValue);
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(2),
        child: RaisedButton(
          //color: Colors.green[300],
          highlightColor: Colors.red,
          onHighlightChanged: (valor) {
            if (valor == true) {
              i = directionValue;
            } else {
              i = 5;
            }
            publishLocation(topic_pup1, i.toString());
          },
          //animationDuration: Duration(seconds: 2),
          onPressed: () {},
          child: Icon(icon),
        ));
  }
}
