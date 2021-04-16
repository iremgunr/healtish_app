import 'package:flutter/material.dart';
import 'package:healtish_app/model/sampleUsers.dart';

class Login_screen extends StatelessWidget {
  static final String path = "lib/src/pages/login/login1.dart";
  final SampleUsers sampleUser;

  const Login_screen({Key key, this.sampleUser}) : super(key: key);

  Widget _buildPageContent() {
    var email = "";
    var password = "";

    void checkLogin(String _email, String _password) {
      if (sampleUser.email == _email && sampleUser.password == _password) {
        //TODO: rotate to home page
      } else {
        // TODO: Show error popUp.
      }
    }

    return Container(
      padding: EdgeInsets.all(20.0),
      color: const Color(0xFFE9E9E9),
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Container(
                width: 200,
              ),
              SizedBox(
                height: 40,
              ),
              Column(
                children: <Widget>[
                  SizedBox(width: 20),
                  Text("Welcome"),
                  SizedBox(width: 20),
                  Text("Log in to continue"),
                  SizedBox(width: 20),
                ],
              ),
              Divider(color: const Color(0XFF200087)),
              ListTile(
                  title: TextField(
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                    hintText: "Email address:",
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                    fillColor: Colors.black,
                    icon: Icon(
                      Icons.email,
                      color: Colors.black,
                    )),
              )),
              Divider(color: const Color(0XFF200087)),
              ListTile(
                  title: TextField(
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                    hintText: "Password:",
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    )),
              )),
              Divider(color: const Color(0XFF200087)),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        checkLogin(email, password);
                      },
                      color: const Color(0XFF200087),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white70, fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Sign In',
                style: TextStyle(color: Colors.grey.shade500),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(),
    );
  }
}
