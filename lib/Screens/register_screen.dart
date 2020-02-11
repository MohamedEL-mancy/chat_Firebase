import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:real_chat/Screens/chat_screen.dart';
import 'package:real_chat/utilities/login&register.dart';

class RegisterScreen extends StatefulWidget {
  static final String id = "RegisterScreen";
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;

  String email;
  String password;

  bool showSpinner = false;

  AnimationController _controller;
  Animation _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    _controller.forward();
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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Image.asset(
                "images/logo.png",
                height: _animation.value * 200.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFields(
                hint: "Enter Your Email",
                type: TextInputType.emailAddress,
                pass: false,
                data: (value) {
                  email = value;
                }),
            SizedBox(
              height: 20.0,
            ),
            TextFields(
                hint: "Enter Your Password",
                pass: true,
                data: (value) {
                  password = value;
                }),
            SizedBox(
              height: 20.0,
            ),
            Buttons(
              type: "Register",
              onPress: () async {
                setState(() {
                  showSpinner = true;
                });

                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  if (newUser != null) {
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                  setState(() {
                    showSpinner = false;
                  });
                } catch (e) {
                  print(e);
                }
              },
              colour: Colors.blueAccent,
            )
          ],
        ),
      ),
    );
  }
}
