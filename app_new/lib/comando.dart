import 'dart:convert';
import 'package:app_new/mqttcommunication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio_slider/flutter_radio_slider.dart';
import 'package:http/http.dart' as http;

int i = 180;
int j = 180;
int k = 180;
int l = 180;
int m = 180;
const _base = 'https://coco-1f532.firebaseio.com/';
double _currentSliderValue0 = 0;
double _currentSliderValue1 = 0;
double _currentSliderValue2 = 0;
double _currentSliderValue3 = 0;
double _currentSliderValue4 = 0;

class HomeScreent extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreent> {
  @override
  Widget build(BuildContext context) {
    final themeData = SliderTheme.of(context).copyWith(
        trackHeight: 10,
        overlayColor: Colors.lightGreen.withAlpha(32),
        activeTickMarkColor: Colors.lightGreen,
        activeTrackColor: Colors.grey[300],
        inactiveTrackColor: Colors.grey[300],
        inactiveTickMarkColor: Colors.grey[500]);
    return Scaffold(
        appBar: AppBar(
          title: Text('Comandos'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      value: _currentSliderValue0,
                      min: 0,
                      max: 180,
                      divisions: 18,
                      label: _currentSliderValue0.round().toString(),
                      onChanged: (double value1) {
                        setState(() {
                          publishLocation(
                              topic_pup1, value1.round().toString());
                          _currentSliderValue0 = value1;
                        });
                      },
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      value: _currentSliderValue1,
                      min: 0,
                      max: 180,
                      divisions: 18,
                      label: _currentSliderValue1.round().toString(),
                      onChanged: (double value2) {
                        setState(() {
                          publishLocation(
                              topic_pup2, value2.round().toString());
                          _currentSliderValue1 = value2;
                        });
                      },
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      value: _currentSliderValue2,
                      min: 0,
                      max: 180,
                      divisions: 18,
                      label: _currentSliderValue2.round().toString(),
                      onChanged: (double value3) {
                        setState(() {
                          publishLocation(
                              topic_pup3, value3.round().toString());
                          _currentSliderValue2 = value3;
                        });
                      },
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      value: _currentSliderValue3,
                      min: 0,
                      max: 180,
                      divisions: 18,
                      label: _currentSliderValue3.round().toString(),
                      onChanged: (double value4) {
                        setState(() {
                          publishLocation(
                              topic_pup4, value4.round().toString());
                          _currentSliderValue3 = value4;
                        });
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Slider(
                value: _currentSliderValue4,
                min: 0,
                max: 180,
                divisions: 18,
                label: _currentSliderValue4.round().toString(),
                onChanged: (double value5) {
                  setState(() {
                    publishLocation(topic_pup5, value5.round().toString());
                    _currentSliderValue4 = value5;
                  });
                },
              ),
            ],
          ),
        ));
  }
}
