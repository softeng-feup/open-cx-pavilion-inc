import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _email;
  String _username;

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
                  'Sign Up',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                  onSaved: (value) => _email = value,
                  keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a email';
                  }
                  return null;
                },
                decoration: new InputDecoration(
                  labelText: "Email",
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
                  onSaved: (value) => _username = value,
               validator: (value) {
                 if (value.isEmpty) {
                   return 'Please enter a username';
                 }
                 return null;
               },
               decoration: new InputDecoration(
                 labelText: "Username",
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
                  onSaved: (value) => _password = value,
                  obscureText: true,
               validator: (value) {
                 if (value.isEmpty) {
                   return 'Please enter your password';
                 }
                 return null;
               },
               decoration: new InputDecoration(
                 labelText: "Password",
                 fillColor: Colors.white,
                 border: new OutlineInputBorder(
                   borderRadius: new BorderRadius.circular(25.0),
                   borderSide: new BorderSide(),
                 ),
                 //fillColor: Colors.green
               ),
                ),
              SizedBox(height: 20),
              SizedBox(
                width:400,
                height: 50,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0), side: BorderSide()),
                  color: Colors.black,
                  child: Text(
                      "Sign up",
                      style: TextStyle(color: Colors.white, fontSize: 20,   fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,)),
                  onPressed: () {
                    // save the fields..
                    final form = _formKey.currentState;
                    form.save();

                    // Validate will return true if is valid, or false if invalid.
                    if(form.validate()) {
                      Navigator.of(context).pushNamed("/home");
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

