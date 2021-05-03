import 'package:flutter/material.dart';
import 'package:healtish_app/ui/pages/calorie_calculator_screen.dart';
import 'package:healtish_app/ui/pages/home_screen.dart';
import 'package:healtish_app/ui/pages/onboarding_screen.dart';
import 'package:healtish_app/ui/pages/profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalorieCalculatorScreen(),

    );
  }
}
