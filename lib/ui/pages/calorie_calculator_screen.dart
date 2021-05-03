import 'package:flutter/material.dart';
import 'dart:async';
import 'package:healtish_app/ui/pages/profile_screen.dart';

class CalorieCalculatorScreen extends StatefulWidget {
  @override
  _CalorieCalculatorScreenState createState() => new _CalorieCalculatorScreenState();
}

class _CalorieCalculatorScreenState extends State<CalorieCalculatorScreen> {
  int calorieBase;
  int calorieActivity;
  int radioSelected;
  double weight;
  double age;
  bool gender = false;
  double height = 170.0;
  Map mapActivite = {0: "rare", 1: "sometimes", 2: "frequently"};

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusScope.of(context).requestFocus(new FocusNode())),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              padding(),
              textStyle(
                  "Please Fill in all the fields to get your daily calorie requirement."),
              padding(),
              Card(
                elevation: 10.0,
                child: Column(
                  children: <Widget>[
                    padding(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        textStyle("Women", color: Colors.pink),
                        Switch(
                            value: gender,
                            inactiveTrackColor: Colors.pink,
                            activeTrackColor: Colors.blue,
                            onChanged: (bool b) {
                              setState(() {
                                gender = b;
                              });
                            }),
                        textStyle("Men", color: Colors.blue)
                      ],
                    ),
                    padding(),
                    RaisedButton(
                        color: Color(0XFF200087),
                        child: textStyle(
                            (age == null)
                                ? "Please enter your age "
                                : " Your age is : ${age.toInt()}",
                            color: Colors.white),
                        onPressed: (() => showPicker())),
                    padding(),
                    textStyle("Your height is: ${height.toInt()} cm.",
                        color: Color(0XFF200087)),
                    padding(),
                    Slider(
                      value: height,
                      activeColor: Color(0XFF200087),
                      onChanged: (double d) {
                        setState(() {
                          height = d;
                        });
                      },
                      max: 215.0,
                      min: 100.0,
                    ),
                    padding(),
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (String string) {
                        setState(() {
                          weight = double.tryParse(string);
                        });
                      },
                      decoration: InputDecoration(
                          labelText: "    Enter your weight in kilograms."),
                    ),
                    padding(),
                    textStyle("What is your sporting activity?",
                        color: Color(0XFF200087)),
                    padding(),
                    rowRadio(),
                    padding()
                  ],
                ),
              ),
              padding(),
              RaisedButton(
                color: Color(0XFF200087),
                child: textStyle("Calculate", color: Colors.white),
                onPressed: calculateNeededCalories,
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding padding() {
    return Padding(padding: EdgeInsets.only(top: 20.0));
  }

  Future<Null> showPicker() async {
    DateTime choice = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light().copyWith(
              primary: Color(0xFF200087),
            ),
          ),
          child: child,
        );
      },
    );

    if (choice != null) {
      var difference = DateTime.now().difference(choice);
      var days = difference.inDays;
      var years = (days / 365);
      setState(() {
        age = years;
      });
    }
  }


  Text textStyle(String data, {color: Colors.black54, fontSize: 15.0}) {
    return Text(data,
        textAlign: TextAlign.center,
        style: TextStyle(color: color, fontSize: fontSize));
  }

  Row rowRadio() {
    List<Widget> l = [];
    mapActivite.forEach((key, value) {
      Column column = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Radio(
              activeColor: Color(0XFF200087),
              value: key,
              groupValue: radioSelected,
              onChanged: (Object i) {
                setState(() {
                  radioSelected = i;
                });
              }),
          textStyle(value, color: Colors.black)
        ],
      );
      l.add(column);
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: l,
    );
  }

  void calculateNeededCalories() {
    if (age != null && weight != null && radioSelected != null) {
      if (gender) {
        calorieBase =
            (66.4730 + (13.7516 * weight) + (5.0033 * height) - (6.7550 * age))
                .toInt();
      } else {
        calorieBase =
            (655.0955 + (9.5634 * weight) + (1.8496 * height) - (4.6756 * age))
                .toInt();
      }
      switch (radioSelected) {
        case 0:
          calorieActivity = (calorieBase * 1.2).toInt();
          break;
        case 1:
          calorieActivity = (calorieBase * 1.5).toInt();
          break;
        case 2:
          calorieActivity = (calorieBase * 1.8).toInt();
          break;
        default:
          calorieActivity = calorieBase;
          break;
      }

      setState(() {
        dialogue();
      });
    } else {
      alert();
    }
  }

  Future<Null> dialogue() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return SimpleDialog(
            contentPadding: EdgeInsets.all(15.0),
            children: <Widget>[
              SafeArea(
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  alignment: Alignment.topLeft,
                ),
              ),
              Center(
                child: Text(
                  'RESULTS',
                  style: TextStyle(
                      color: Color(0XFF200087),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              SizedBox(height: 30),
              textStyle("Your daily calorie need is :  $calorieBase",
                  color: Colors.black38),
              SizedBox(height: 15),
              textStyle("Your need with sports activity is : $calorieActivity",
                  color: Colors.black38),
              SizedBox(height: 14),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
                child: textStyle("Go to Recipes", color: Colors.white70),
                color: Color(0XFF200087),
              )
            ],
          );
        });
  }

  Future<Null> alert() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: textStyle("Error!",color: Colors.red),
            content: textStyle("All fields are not filled!"),
            actions: <Widget>[
              Container(
                color: Colors.white60,
                child: FlatButton(
                    onPressed: () {
                      Navigator.pop(buildContext);
                    },
                    child: textStyle("OK", color: Colors.red)),
              ),
            ],
          );
        });
  }
}
