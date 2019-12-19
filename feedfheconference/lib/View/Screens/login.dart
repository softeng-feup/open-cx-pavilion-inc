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
                  'Log in',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                height: 50,
                child: TextFormField(
                  onSaved: (value) => _emailOrUsername = value,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Email/Username"
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: TextFormField(
                  /*validator:
                      (value) {
                    return 'Email/Username or Password Wrong';},*/
                  onSaved: (value) => _password = value,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Password"
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width:400,
                height: 50,
                child: RaisedButton(
                  color: Colors.black,
                  child: Text(
                      "LOG IN",
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    // save the fields..
                    final form = _formKey.currentState;
                    form.save();
                    // Validate will return true if is valid, or false if invalid.
                    if(form.validate()) {
                     /* for (var i = 0; i < db.userList.length; i++) {
                        if (db.userList[i].email == _emailOrUsername ||
                            db.userList[i].UserName == _emailOrUsername) {
                          if (db.userList[i].password == _password) {*/
                            Navigator.of(context).pushNamed("/home");
                          //}

                      //  }
                     // }
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
