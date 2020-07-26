import 'package:flutter/material.dart';

Color kdarkGrey = Color(0xFF212128);
Color kOrange = Colors.redAccent;

InputDecoration createInputDecor(String hintText) {
  return InputDecoration(
    labelText: "Enter $hintText",
    fillColor: Colors.white,
    border: new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(20.0),
      borderSide: new BorderSide(),
    ),
    errorStyle: TextStyle(color: Colors.white.withOpacity(0.95)),
  );
}
String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}
String validateName(String value) {
  if (value.length < 3)
    return 'Increase Length';
  else
    return null;
}

