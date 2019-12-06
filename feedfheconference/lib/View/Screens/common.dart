import 'package:feedfheconference/View/Screens/favorites.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';

Drawer sideDrawer(BuildContext context) {
  return new Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the drawer if there isn't enough vertical
    // space to fit everything.
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.12,
          child: DrawerHeader(
              child: Text('Menu', style: TextStyle(color: Colors.white)),
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Color.fromRGBO(3, 44, 115, 1),
              )),
        ),
        ListTile(
          title: Text('Home Page'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed("/home");
          },
        ),
        ListTile(
          title: Text('Favorites'),
          onTap: () {
            var route = MaterialPageRoute(
              builder: (BuildContext context) => FavoritesPage()
            );
            Navigator.of(context).pop();
            Navigator.of(context).push(route);
          },
        ),
        ListTile(
          title: Text('My Profile'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed("/profile");
          },
        ),
      ],
    ),
  );
}


String monthOfTheYear(DateTime d){
  
  String month;
  switch(d.month){
    
    case 1:
      month = "Jan";
    break;
    
    case 2:
      month = "Feb";
    break;
    
    case 3:
      month = "Mar";
    break;

    case 4:
      month = "Apr";
    break;
    
    case 5:
      month = "May";
    break;
    
    case 6:
      month = "Jun";
    break;

    case 7:
      month = "Jul";
    break;
    
    case 8:
      month = "Aug";
    break;
    
    case 9:
      month = "Sep";
    break;

    case 10:
      month = "Oct";
    break;
    
    case 11:
    month = "Nov";
    break;
    
    case 12:
      month = "Dec";
    break;
    
    default:
      month = null;
    break;
  }

  return month;
}


