import 'package:flutter/material.dart';

const kFlashStyle = TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold);

const kTextButtonStyle = TextStyle(color: Colors.white, fontSize: 16.0);

final kTextFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.0),
    borderSide: BorderSide(color: Colors.blue));

const kTextFieldChat = InputDecoration(
    hintText: "Type Your message here",
    contentPadding: EdgeInsets.all(20.0),
    border: InputBorder.none);

const kSendButtonStyle = TextStyle(color: Colors.blueAccent, fontSize: 18.0);
