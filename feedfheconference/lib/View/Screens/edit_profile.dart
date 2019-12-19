import 'package:feedfheconference/Model/db.dart';
import 'package:feedfheconference/View/Screens/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

void main() => runApp(EditProfilePage());

class EditProfilePage extends StatelessWidget {
  final String username;


  @override
  EditProfilePage({Key key, this.username}): super(key: key);
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
    var name = get_name_from_username(username);
    var email = get_email_from_username(username);
    var permitionLevel = get_permissions_from_username(username);

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
      resizeToAvoidBottomPadding: false,
      body: Column(
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
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: new Icon(Icons.email, color: Colors.white,)
                  ),

                  Expanded(
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      minLines: 1,
                      maxLines: 1,
                      initialValue: email,
                      decoration: new InputDecoration(
                        labelText: "Email",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(50.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: new Icon(Icons.face, color: Colors.white,)
                  ),

                  Expanded(
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      minLines: 1,
                      maxLines: 1,
                      initialValue: username,
                      decoration: new InputDecoration(
                        labelText: "Username",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(50.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: new Icon(Icons.security, color: Colors.white,)
                  ),

                  Expanded(
                    child: TextFormField(
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      minLines: 1,
                      maxLines: 1,
                      decoration: new InputDecoration(
                        labelText: "New Password",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(50.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: new Icon(Icons.security, color: Colors.white,)
                  ),

                  Expanded(
                    child: TextFormField(
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      minLines: 1,
                      maxLines: 1,
                      decoration: new InputDecoration(
                        labelText: "Confirm New Password",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(50.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
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
              margin: EdgeInsets.only(top: 30),
              child:
              FlatButton(
                onPressed: (){
                  print('Click');
                  },
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      child: Icon(Icons.check, color: _color),
                    ),
                    Text('Submit Changes', style: TextStyle(color: _color, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
          ],
        ),
      backgroundColor: Colors.lightBlueAccent[100],
    );
  }
}
