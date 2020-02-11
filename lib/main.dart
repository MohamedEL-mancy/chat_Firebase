import 'package:flutter/material.dart';

import 'Screens/chat_screen.dart';
import 'Screens/login.dart';
import 'Screens/register_screen.dart';
import 'Screens/welcome_Screen.dart';

void main() => runApp(ChatApp());

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        ChatScreen.id: (context) => ChatScreen()
      },
    );
  }
}
