import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:notefy/models/classes/user.dart';
import 'package:notefy/constants.dart';

Future<String> createUser(String firstname, String lastname, String username,
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
  var parsedJson = json.decode(response.body);
  if(response.statusCode/10==20){
    print(response.statusCode);
    print(parsedJson['api_key']);
     return parsedJson['api_key'];
  }else{
    return null;
  }
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
  bool _obscureText = true;
  void _toggleHideUnhide() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
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
                        final String fn = firstname.text;
                        final String ln = lastname.text;
                        final String un = username.text;
                        final String em = email.text;
                        final String ps = password.text;
                        String apikey = await createUser(firstname.text, lastname.text, username.text,
                            email.text, password.text);
                        print("Called");
                        _saveApiKey(apikey);
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
  void _saveApiKey(String apikey) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'api_key', value: apikey);
    print('Saved');
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
