import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notefy/models/classes/user.dart';
import 'package:notefy/constants.dart';

Future<UserData> createUser( String firstname, String lastname, String username,String email, String password) async{
  final String apiUrl = 'http://127.0.0.1:5000/register';
  final response = await http.post(
    apiUrl,
    body: jsonEncode({
      "username": username,
      "email": email,
      "firstname":firstname,
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: kOrange,
        child: Container(
          padding: EdgeInsets.only(top: size.height/8),
          margin: EdgeInsets.only(left: 20,right: 20),
          child: ListView(
            children: [
              Text('Register Here',style: TextStyle(fontSize: 50, fontWeight: FontWeight.w800),),
              SizedBox(height: 40,),
              TextField(
                controller: firstname,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20),
                  hintText: 'First Name',
                ),
              ),
              TextField(
                controller: lastname,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20),
                  hintText: 'Last Name',
                ),
              ),
              TextField(
                controller: username,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20),
                  hintText: 'Username',
                ),
              ),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20),
                  hintText: 'email',
                ),
              ),
              TextField(
                controller: password,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20),
                  hintText: 'Set Password',
                ),
              ),
              RaisedButton(
                child: Text('Sign up'),
                textColor: Colors.white,
                color: kdarkGrey,
                onPressed: () async {
                  final String fn = firstname.text;
                  final String ln = lastname.text;
                  final String un = username.text;
                  final String em = email.text;
                  final String ps = password.text;
                  createUser(firstname.text, lastname.text, username.text, email.text, password.text);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
