import 'package:flutter/material.dart';
import 'package:healtish_app/ui/pages/home_screen.dart';
import 'package:intl/intl.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var pages = [
    PageViewModel(
      title: "Do you want to beautiful body?",
      body:
          "Why dont you start to exercise?",
      image: Center(child: Image.asset("assets/4.png", height: 175.0)),
      decoration: const PageDecoration(
        pageColor: Colors.white70,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fitness Time!",
          style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0XFF200087),
      ),
      body: IntroductionScreen(
        pages: pages,
        onDone: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        onSkip: () {
          // You can also override onSkip callback
        },
        showSkipButton: true,
        skip: const Icon(
          Icons.skip_next,
          color: Color(0XFF200087),
        ),
        next: const Icon(
          Icons.arrow_right,
          color: Color(0XFF200087),
        ),
        done: const Text(
          "Let's Start!",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0XFF200087),
            fontSize: 20
          ),
        ),
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor:Colors.white70,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}
