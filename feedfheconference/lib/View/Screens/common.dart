import 'package:feedfheconference/View/Screens/favorites.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:feedfheconference/View/Screens/profile.dart';
import 'package:feedfheconference/View/Screens/home.dart';

Drawer sideDrawer(BuildContext context, String username) {

  var routeProfile = MaterialPageRoute(
    builder: (BuildContext context) => new ProfilePage(username: username),
  );
   var routeFavorites = MaterialPageRoute(
    builder: (BuildContext context) => new FavoritesPage(username: username),
  );

  var routeHomepage = MaterialPageRoute(
                        builder: (BuildContext context) => new HomePage(username: username),
  );

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
            Navigator.of(context).pushReplacement(routeHomepage);
          },
        ),
        ListTile(
          title: Text('Favorites'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(routeFavorites);
          },
        ),
        ListTile(
          title: Text('My Profile'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(routeProfile);
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


