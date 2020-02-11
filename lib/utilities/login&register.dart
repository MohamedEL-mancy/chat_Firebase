import 'package:flutter/material.dart';

import 'constants.dart';

class Buttons extends StatelessWidget {
  final String type;
  final Color colour;
  final Function onPress;
  Buttons({this.type, this.colour, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          color: colour,
          padding: EdgeInsets.symmetric(horizontal: 140.0, vertical: 14.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onPressed: onPress,
          child: Text(
            type,
            style: kTextButtonStyle,
          ),
        )
      ],
    );
  }
}

class TextFields extends StatelessWidget {
  final String hint;
  final TextInputType type;
  final bool pass;
  final Function data;
  TextFields({this.hint, this.type, this.pass, this.data});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 18.0, right: 18.0),
          child: TextField(
            keyboardType: type,
            obscureText: pass,
            onChanged: data,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              focusedBorder: kTextFieldBorder,
              enabledBorder: kTextFieldBorder,
              hintText: hint,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
