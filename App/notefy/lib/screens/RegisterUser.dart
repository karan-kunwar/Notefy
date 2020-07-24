import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notefy/models/classes/user.dart';
import 'package:notefy/constants.dart';

Future<UserData> createUser(String firstname, String lastname, String username,
    String email, String password) async {
  final String apiUrl = 'http://127.0.0.1:5000/register';
  final response = await http.post(apiUrl,
      body: jsonEncode({
        "username": username,
        "email": email,
        "firstname": firstname,
        "lastname": lastname,
        "password": password
      }));
  print(response.statusCode);
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController username = TextEditingController();

  bool _autoValidate = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: kOrange,
        child: Container(
          padding: EdgeInsets.only(top: 30),
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: ListView(
              children: [
                Text(
                  'Register Here',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: firstname,
                  decoration: createInputDecor('First Name'),
                  keyboardType: TextInputType.name,
                  validator: validateName,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: lastname,
                  decoration: createInputDecor('Last Name'),
                  keyboardType: TextInputType.name,
                  validator: validateName,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: username,
                  decoration: createInputDecor('Username'),
                  keyboardType: TextInputType.text,
                  validator: validateName,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: email,
                  decoration: createInputDecor('Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: password,
                  decoration: createInputDecor('Set Password'),
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                    child: Text('Sign up'),
                    textColor: Colors.white,
                    color: kdarkGrey,
                    shape: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                    onPressed: () async {
                      if (_validateInputs()) {
                        final String fn = firstname.text;
                        final String ln = lastname.text;
                        final String un = username.text;
                        final String em = email.text;
                        final String ps = password.text;
                        createUser(firstname.text, lastname.text, username.text,
                            email.text, password.text);
                      }
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      return true;
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
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
}

InputDecoration createInputDecor(String hintText) {
  return InputDecoration(
    labelText: "Enter $hintText",
    fillColor: Colors.white,
    border: new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(25.0),
      borderSide: new BorderSide(),
    ),
    //fillColor: Colors.green
  );
}
