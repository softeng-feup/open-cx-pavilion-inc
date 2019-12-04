import 'dart:ffi';

import 'package:flutter/material.dart';
import '../../Model/db.dart';

class StatisticsForForm extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _emailOrUsername;

  @override
  Widget build(BuildContext context) {


class StatisticsForForm extends StatelessWidget {

  int formId;

  StatisticsForForm(formId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/background.jpg"), fit: BoxFit.cover),
          ),
          child: Stack(
            children: <Widget>[
              TitleHome('FEEDTHECONFERENCE'),
              MyButton(
                  x: 25,
                  y: 60,
                  title: "Login",
                  onPressed: () {
                    Navigator.of(context).pushNamed("/login");
                  }),
              MyButton(
                  x: 25,
                  y: 75,
                  title: "Sign Up",
                  onPressed: () {
                    Navigator.of(context).pushNamed("/register");
                  })
            ],
          ),
        ),
      ),
    );
  }
}
