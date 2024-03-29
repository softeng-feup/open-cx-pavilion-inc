import 'package:flutter/material.dart';

import 'Screens/favorites.dart';
import 'Screens/login.dart';
import 'Screens/register.dart';
import 'Screens/home.dart';
import 'Screens/form.dart';
import 'Screens/conference_home.dart';
import 'Screens/profile.dart';


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FeedTheConference',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(3, 44, 115, 1),
      ),
      initialRoute: '/',
      routes: {
        "/": (context) => StartPage(),
        "/login": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/home": (context) => HomePage(),
        "/form": (context) => FormPage(),
        "/conference_home": (context) => ConferenceHomePage(),
        "/favorites": (context) => FavoritesPage(),
        "/profile": (context) => ProfilePage()
      },
    );
  }
}

class StartPage extends StatelessWidget {
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

class TitleHome extends StatelessWidget {
  final String questionText;

  TitleHome(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          top: 200,
          left: 0,
          right: 0,
          bottom: 470,
        ),
        alignment: Alignment.topCenter,
        child: Text(
          questionText,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ));
  }

}

class MyButton extends StatelessWidget {
  MyButton({this.x, this.y, this.title, this.onPressed});

  final int x;
  final int y;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: (x / 100) * MediaQuery.of(context).size.width,
        top: (y / 100) * MediaQuery.of(context).size.height,
        child: SizedBox(
          width: 200, // specific value
          height: 50,
          child: FloatingActionButton(
            onPressed: onPressed,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(0),
                side: BorderSide(color: Colors.black)),
            backgroundColor: Colors.black,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            heroTag: title,
          ),
        ));
  }
}