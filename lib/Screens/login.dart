import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:real_chat/Screens/chat_screen.dart';
import 'package:real_chat/utilities/login&register.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static final String id = "LoginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;

  String email, password;
  bool showSpinner = false;

  AnimationController _controller;
  Animation _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInCirc);
    _controller.forward();
    _controller.addListener(
      () {
        setState(() {});
      },
    );
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
                height: _animation.value * 160.0,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            TextFields(
              hint: "Enter Your Email",
              type: TextInputType.emailAddress,
              pass: false,
              data: (value) {
                email = value;
              } 
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFields(
              hint: "Enter Your Password",
              pass: true,
              data: (value) 
              {
                password = value;
              } 
            ),
            SizedBox(
              height: 20.0,
            ),
            Buttons(
              type: "Log In",
              onPress: () async {
                setState(() {
                  showSpinner = true;
                });
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                  setState(() {
                    showSpinner = false;
                  });
                } catch (e) {
                  print(e);
                }
              },
              colour: Colors.blue[300],
            ),
          ],
        ),
      ),
    );
  }
}
