import 'package:feedfheconference/Controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

import 'edit_profile.dart';

void main() => runApp(ProfilePage());

class ProfilePage extends StatelessWidget {

  final String username;

  @override
  ProfilePage({Key key, this.username}): super(key: key);
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(username),
    );
  }
}

class Home extends StatelessWidget {

  final String username;
  void _showDialog(BuildContext context, {String title, String msg}) {
    final dialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: <Widget>[
        RaisedButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Close',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
    showDialog(context: context, builder: (x) => dialog);
  }

  Home(this.username);

  @override
  Widget build(BuildContext context) {

    var name = controller.get_name_from_username(username);
    var email = controller.get_email_from_username(username);
    var permitionLevel = controller.get_permissions_from_username(username);

    //Used for profile 'icon'
    var _initialLetter = name[0].toUpperCase();
    RandomColor _random_color = RandomColor();

    Color _color = _random_color.randomColor(
      colorBrightness: ColorBrightness.light
    );

    //Used for profile permition level
    var permitionLevelString;
    permitionLevelString = permitionLevel.toString().substring(10); //Retira "user_type."


    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child:CircleAvatar(
                  backgroundColor: _color,
                  foregroundColor: Colors.white,
                  radius: 45,
                  child: Text(_initialLetter, style:TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0)),
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              alignment: Alignment.center,
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 35.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico',
                ),
              ),
            ),

            SizedBox(
              height: 50,
              width: 200,
              child: Divider(
                color: Colors.white,
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: new Icon(Icons.email, color: Colors.white,)
                  ),
                  new Text(email, style: TextStyle(color: Colors.white))
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: new Icon(Icons.assignment_ind, color: Colors.white),
                  ),
                  new Text(permitionLevelString, style: TextStyle(color: Colors.white),)
                ],
              ),
            ),

            Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 30 ,bottom: 15),
              child:
              FlatButton(
                onPressed: (){
                    var route = MaterialPageRoute(
                      builder: (BuildContext context) => new EditProfilePage(username: username),
                    );
                    Navigator.of(context).pushReplacement(route);
                  },
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      child: Icon(Icons.edit, color: _color),
                    ),
                    Text('Edit Profile', style: TextStyle(color: _color, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
      backgroundColor: Colors.lightBlueAccent[100],
    );
  }
}
