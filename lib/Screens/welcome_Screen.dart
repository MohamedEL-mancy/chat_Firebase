import 'package:flutter/material.dart';
import 'package:real_chat/Screens/login.dart';
import 'package:real_chat/Screens/register_screen.dart';
import 'package:real_chat/utilities/constants.dart';
import 'package:real_chat/utilities/login&register.dart';

class WelcomeScreen extends StatefulWidget {
  static final String id = "WelcomeScreen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _controller.forward();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _animation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse(from: 1.0);
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      },
    );

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset("images/logo.png", width: _controller.value * 100.0),
              Text(
                "Flash Chat",
                style: kFlashStyle,
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Buttons(
            type: "Log in",
            colour: Colors.blue.shade300,
            onPress: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          Buttons(
            type: "Register",
            colour: Colors.blueAccent.shade100,
            onPress: () {
              Navigator.pushNamed(context, RegisterScreen.id);
            },
          ),
        ],
      ),
    );
  }
}
