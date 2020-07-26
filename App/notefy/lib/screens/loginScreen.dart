import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:notefy/constants.dart';
import 'package:notefy/main.dart';
import 'package:notefy/models/classes/user.dart';
import 'package:notefy/screens/RegisterUser.dart';
import 'package:http/http.dart' as http;

Future<bool> signInUser(String username, String password) async {
  final String apiUrl = 'http://127.0.0.1:5000/signin';
  final response = await http.post(apiUrl,
      body: jsonEncode({
        "username": username,
        "password": password
      }));
  var parsedJson = json.decode(response.body);
  print(parsedJson);
  if(response.statusCode/10==20){
//    UserData user;
//    user.firstname = parsedJson['firstname'];
//    user.lastname = parsedJson['lastname'];
//    user.username = parsedJson['username'];
//    user.email = parsedJson['email'];
//    return user;
      return true;
  }else{
    return null;
  }
}


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController password = TextEditingController();
  final TextEditingController username = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _obscureText = true;
  void _toggleHideUnhide() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: kOrange,
          child: Container(
            padding: EdgeInsets.only(top: size.height/8),
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Form(
                  key: _formKey,
                  autovalidate: _autoValidate,
                  child: ListView(
                    children: [
                      Center(
                        child: Text(
                          'Welcome',
                          style: TextStyle(fontSize: 50, fontWeight: FontWeight.w800),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        controller: username,
                        decoration: createInputDecor('Username'),
                        keyboardType: TextInputType.name,
                        validator: validateName,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: <Widget>[
                          new TextFormField(
                            controller: password,
                            decoration: createInputDecor('Password'),
                            validator: (val) => val.length < 6 ? 'Password too short.' : null,
                            obscureText: _obscureText,
                          ),
                          new FlatButton(
                              onPressed: _toggleHideUnhide,
                              child: new Text(_obscureText ? "Show" : "Hide"))
                        ],
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
                              final String un = username.text;
                              final String ps = password.text;
                              if(await signInUser(un, ps)) {
                                print('Welcome'+un);
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) => FirstScreen()
                                    )
                                );
                              }
                            }
                          }
                      ),
                      RaisedButton (
                          child: Text('New User? Register'),
                          textColor: Colors.white,
                          color: kdarkGrey,
                          shape: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder:(context)=>RegisterScreen()
                                )
                            );
                          }
                      ),
                    ],
                  ),
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
}
