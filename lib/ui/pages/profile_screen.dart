import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:healtish_app/model/meal.dart';
import 'package:healtish_app/model/motivation.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:intl/intl.dart';
import 'stepCount_screen.dart';
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final today = DateTime.now();

    return Scaffold(
        backgroundColor: const Color(0xFFE9E9E9),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          child: BottomNavigationBar(
            iconSize: 40,
            selectedIconTheme: IconThemeData(
              color: const Color(0xFF200087),
            ),
            unselectedIconTheme: IconThemeData(color: Colors.black12),
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  child: Icon(Icons.home),
                  padding: const EdgeInsets.only(top: 8.0),
                ),
                title: Text(
                  "Home",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  child: Icon(Icons.person),
                  padding: EdgeInsets.only(top: 8.0),
                ),
                title: Text(
                  "Profile",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              height: height * 0.34,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    bottom: const Radius.circular(40)),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(
                      top: 40, left: 32, right: 16, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "${DateFormat("EEEE").format(today)},${DateFormat(" d MMMM").format(today)}",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                        subtitle: Text(
                          "Hello World",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        trailing: ClipOval(
                          child: Image.asset("assets/user.jpeg"),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _RadialProgress(
                            width: height * 0.15,
                            height: height * 0.14,
                            progress: 0.7,
                          ),
                          _Motivation(
                              motivation: motivations[
                                  Random().nextInt(motivations.length - 1)])
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: height * 0.37,
              left: 0,
              right: 0,
              child: Container(
                height: height * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                        left: 32,
                        right: 16,
                      ),
                      child: Text(
                        "MEALS FOR TODAY",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      ),
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20,
                          ),
                          for (int i = 0; i < meals.length; i++)
                            _MealCard(
                              meal: meals[i],
                            ),
                        ],
                      ),
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => StepCounter()),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              bottom: 65, left: 30, right: 25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(28)),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color(0xFF20008B),
                                const Color(0XFF200087),
                              ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, left: 15.0),
                                  child: Text('STEP CALCULATOR',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800))),
                              SizedBox(height: 4),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                      color: const Color(0xFF5B4D9D),
                                    ),
                                    padding: const EdgeInsets.all(2),
                                    child: Image.asset(
                                      "assets/ppl.png",
                                      width: 316,
                                      height: 60,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class _Motivation extends StatelessWidget {
  final Motivation motivation;

  const _Motivation({Key key, @required this.motivation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .55),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              motivation.motivation,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF200087),
                //fontFamily: 'Yatra One',
                fontSize: 12,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _RadialProgress extends StatelessWidget {
  final double height, width, progress;

  const _RadialProgress({Key key, this.height, this.width, this.progress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RadialPainter(progress: 0.7),
      child: Container(
        height: height,
        width: width,
        child: Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '1700',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: const Color(0XFF200087),

                  ),
                ),
                TextSpan(text: "\n"),
                TextSpan(
                  text: "kcal",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0XFF200087),

                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RadialPainter extends CustomPainter {
  final double progress;

  _RadialPainter({this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 7
      ..color = Color(0xFF200087)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double relativeProgress = 360 * progress;
    canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: size.width / 2,
        ),
        math.radians(-90),
        math.radians(-relativeProgress),
        false,
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _MealCard extends StatelessWidget {
  final Meal meal;

  const _MealCard({Key key, @required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 20,
        left: 10,
      ),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                child: Image.asset(
                  meal.imagePath,
                  width: 150,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      meal.mealTime,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 8,
                          color: Colors.blueGrey),
                    ),
                    Text(
                      meal.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Colors.black),
                    ),
                    Text(
                      '${meal.kiloCaloriesBurnt} kcal',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 8,
                          color: Colors.blueGrey),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          color: Colors.black12,
                          size: 15,
                        ),
                        SizedBox(
                          width: 1,
                        ),
                        Text(
                          '${meal.timeTaken} min',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 8,
                              color: Colors.blueGrey),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
