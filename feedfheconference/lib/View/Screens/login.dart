import 'dart:ffi';

import 'package:feedfheconference/View/Screens/home.dart';
import 'package:flutter/material.dart';
import '../../Model/db.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _emailOrUsername;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("FeedTheConference"),
      ),
      body: Container(
        padding: EdgeInsets.all(40.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              SizedBox(height: 40),
              TextFormField(
                  onSaved: (value) => _emailOrUsername = value,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your email or username';
                    }
                    return null;
                  },
                  decoration: new InputDecoration(
                    labelText: "Username or email",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                ),
              SizedBox(height: 20),
              TextFormField(
                  /*validator:
                      (value) {
                    return 'Email/Username or Password Wrong';},*/
                  onSaved: (value) => _password = value,
                  obscureText: true,
                  decoration: new InputDecoration(
                    labelText: "Password",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your password';
                    } else {
                      for (var i = 0; i < db.userList.length; i++) {
                        if (db.userList[i].email == _emailOrUsername ||
                            db.userList[i].userName == _emailOrUsername) {
                          if (db.userList[i].password == _password) {
                            return null;
                          }
                        }
                      }
                      return 'Username/Email or password incorrect';
                    }
                    return null;
                  },
                ),
              SizedBox(height: 20),
              SizedBox(
                width: 400,
                height: 50,
                
                child: RaisedButton(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0), side: BorderSide()),
                  child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 20,   fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,)),
                  onPressed: () {
                    // save the fields..
                    final form = _formKey.currentState;
                    form.save();
                    // Validate will return true if is valid, or false if invalid.
                    if (form.validate()) {
                      var username;
                      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_emailOrUsername);
                      if(emailValid){
                        for(var i = 0; i < db.userList.length; i++) {
                          if (db.userList[i].email == _emailOrUsername) {
                            username = db.userList[i].userName;
                            break;
                          }
                        }
                      }
                      else{
                        username = _emailOrUsername;
                      }
                      var route = MaterialPageRoute(
                        builder: (BuildContext context) => new HomePage(username: username),
                      );
                      Navigator.of(context).push(route);

                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
