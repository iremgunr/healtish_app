import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pedometer/pedometer.dart';

void main() => runApp(new StepCounter());

class StepCounter extends StatefulWidget {
  @override
  _StepCounterState createState() => _StepCounterState();
}

class _StepCounterState extends State<StepCounter> {
  String viewSteps = "";
  String _km = "Unknown";
  String _calories = "Unknown";
  Pedometer _pedometer;
  String _stepCountValue = 'Unknown';
  StreamSubscription<int> _subscription;
  final today = DateTime.now();
  double _numerox;
  double _convert;
  double _kmx;
  double burnedx;

  @override
  void initState() {
    super.initState();
    //initPlatformState();
    setUpPedometer();
  }

  void setUpPedometer() {
    _pedometer = new Pedometer();
    _subscription = _pedometer.pedometerStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
  }

  void stopListening() {
    _subscription.cancel();
  }

  void _onData(int stepCountValue) async {
    setState(() {
      _stepCountValue = "$stepCountValue";
    });

    var dist = stepCountValue;
    double y = (dist + .0);

    setState(() {
      _numerox = y;
    });

    var long3 = (_numerox);
    long3 = num.parse(y.toStringAsFixed(2));
    var long4 = (long3 / 10000);

    int decimals = 1;
    int fac = pow(10, decimals);
    double d = long4;
    d = (d * fac).round() / fac;
    print("d: $d");

    getDistanceRun(_numerox);

    setState(() {
      _convert = d;
      print(_convert);
    });
  }

  void reset() {
    setState(() {
      int stepCountValue = 0;
      stepCountValue = 0;
      _stepCountValue = "$stepCountValue";
    });
  }

  void _onDone() {}

  void _onError(error) {
    print("Flutter Pedometer Error: $error");
  }

  void getDistanceRun(double _numerox) {
    var distance = ((_numerox * 78) / 100000);
    distance = num.parse(distance.toStringAsFixed(2));
    var distancekmx = distance * 34;
    distancekmx = num.parse(distancekmx.toStringAsFixed(2));
    //print(distance.runtimeType);
    setState(() {
      _km = "$distance";
      //print(_km);
    });
    setState(() {
      _kmx = num.parse(distancekmx.toStringAsFixed(2));
    });
  }

  void getBurnedRun() {
    setState(() {
      var calories = _kmx;
      _calories = "$calories";
      //print(_calories);
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(_stepCountValue);
    getBurnedRun();
    return Scaffold(
      backgroundColor: const Color(0xFF200087),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16,
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Align(
              child: Text(
                "${DateFormat("EEEE").format(today)}, ${DateFormat("d MMMM").format(today)}",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.white,
          
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ListView(
              padding: EdgeInsets.all(5.0),
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10.0),
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Color(0xFFA9F5F2), Color(0xFF01DFD7)],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(27.0),
                      bottomRight: Radius.circular(27.0),
                      topLeft: Radius.circular(27.0),
                      topRight: Radius.circular(27.0),
                    ),
                  ),
                  child: new CircularPercentIndicator(
                    radius: 200.0,
                    lineWidth: 13.0,
                    animation: true,
                    center: Container(
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: 50,
                            padding: EdgeInsets.only(left: 20.0),
                            child: Icon(
                              FontAwesomeIcons.walking,
                              size: 30.0,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            //color: Colors.orange,
                            child: Text(
                              '$_stepCountValue',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.purpleAccent),
                            ),
                            // height: 50.0,
                            // width: 50.0,
                          ),
                        ],
                      ),
                    ),
                    //percent: 0.217,
                    percent: _convert,
                    footer: new Text(
                      "STEPS:  21837238",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Colors.purple),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.purpleAccent,
                  ),
                ),
                Divider(
                  height: 5.0,
                ),
                Container(
                  width: 80,
                  height: 100,
                  padding: EdgeInsets.only(left: 25.0, top: 10.0, bottom: 10.0),
                  color: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      new Container(
                        child: new Card(
                          child: Container(
                            height: 80.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/distance.png"),
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                            child: Text(
                              "$_km Km",
                              textAlign: TextAlign.right,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0),
                            ),
                          ),
                          color: Colors.white54,
                        ),
                      ),
                      VerticalDivider(
                        width: 20.0,
                      ),
                      new Container(
                        child: new Card(
                          child: Container(
                            height: 80.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/burned.png"),
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                          color: Colors.transparent,
                        ),
                      ),
                      VerticalDivider(
                        width: 20.0,
                      ),
                      new Container(
                        child: new Card(
                          child: Container(
                            height: 80.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/step.png"),
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 2,
                ),
                Container(
                  padding: EdgeInsets.only(top: 2.0),
                  width: 150,
                  height: 30,
                  color: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.only(left: 40.0),
                        child: new Card(
                          child: Container(
                            child: Text(
                              "$_km Km",
                              textAlign: TextAlign.right,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                  color: Colors.white),
                            ),
                          ),
                          color: Colors.purple,
                        ),
                      ),
                      VerticalDivider(
                        width: 20.0,
                      ),
                      new Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: new Card(
                          child: Container(
                            child: Text(
                              "$_calories kCal",
                              textAlign: TextAlign.right,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                  color: Colors.white),
                            ),
                          ),
                          color: Colors.red,
                        ),
                      ),
                      VerticalDivider(
                        width: 5.0,
                      ),
                      new Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: new Card(
                          child: Container(
                            child: Text(
                              "$_stepCountValue Steps",
                              textAlign: TextAlign.right,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                  color: Colors.white),
                            ),
                          ),
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 25.0, top: 10.0, bottom: 10.0),
                  color: Colors.black12,
                  child: Row(
                    children: <Widget>[
                      new Container(
                        child: new Card(
                          child: Container(
                            height: 80.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/barras.png"),
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                          color: Colors.white54,
                        ),
                      ),
                      VerticalDivider(
                        width: 20.0,
                      ),
                      new Container(
                        child: new Card(
                          child: Container(
                            height: 80.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/water.png"),
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                          color: Colors.transparent,
                        ),
                      ),
                      VerticalDivider(
                        width: 20.0,
                      ),
                      new Container(
                        child: new Card(
                          child: Container(
                            height: 80.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/heart.png"),
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
