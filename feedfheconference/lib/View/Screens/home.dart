
import 'package:flutter/material.dart';
import '../../Model/db.dart';
import './conference_home.dart';

class HomePage extends StatefulWidget {
  final String title = 'Home Page';

  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        // Added
        length: 2, // Added
        initialIndex: 0, //Added
        child: Scaffold(
          body: buildHomePage(
              context, _tabController, _scrollViewController, widget.title),

          drawer: sideDrawer(context), // Passed BuildContext in function.
        ));
  }
}

NestedScrollView buildHomePage(
    BuildContext context,
    TabController _tabController,
    ScrollController _scrollViewController,
    String title) {
  return new NestedScrollView(
    controller: _scrollViewController,
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        new SliverAppBar(
          title: new Text(title),
          pinned: true,
          floating: true,
          snap: true,
          forceElevated: innerBoxIsScrolled,
        ),
      ];
    },
    body: new CurrentPage(),
  );
}

List<Widget> listMyWidgets() {
  var db = Database();

  db.conferenceList.sort((a, b) =>
      (a.beginDate.dateToString()).compareTo(b.beginDate.dateToString()));

  @override
  List<Widget> widgetsList = new List();

  widgetsList.add(Text(
    'Available Conferences',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
  ));

  for (int i = 0; i < db.conferenceList.length; i++) {
    print(db.conferenceList[i].id);
    print(db.conferenceList[i].name);
    widgetsList.add(EventBox(
        db.conferenceList[i].id,
        db.conferenceList[i].name,
        db.conferenceList[i].place,
        db.conferenceList[i].beginDate,
        db.conferenceList[i].endDate));
  }

  for (int i = 0; i < db.sessionList.length; i++) {}

  return widgetsList;
}

class EventBox extends StatelessWidget {
  String name;
  String place;
  Date beginDate;
  Date endDate;
  int conferenceId;
  EventBox(this.conferenceId,this.name, this.place, this.beginDate, this.endDate);

  @override
  Widget build(BuildContext context) {
    return InkWell(
          onTap: () {

          var route = MaterialPageRoute(
            builder: (BuildContext context) => new ConferenceHomePage(conferenceId: conferenceId),
          );  
          Navigator.of(context).push(route);
          }, // handle your onTap here
          child: Container(
              color: Color.fromARGB(60, 0, 0, 255),
              margin: const EdgeInsets.only(top: 10.0),
              padding: const EdgeInsets.only(top: 10.0),
              child: Stack(
                children: [
                      Container(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      //color: Colors.green[200],
                      //width: 215,
                      width: MediaQuery.of(context).size.width - 145,
                      child: Column(
                        children: <Widget>[
                          Text(
                            name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 5),
                          Text(
                            place,
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          SizedBox(height: 5),
                          Text(
                              beginDate.dateToInvertedString() +
                                  ' <-> ' +
                                  endDate.dateToInvertedString(),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                        ],
                      ),
                    ),
                ],
              )));
  }
}

class CurrentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      padding: EdgeInsets.zero,
      children: listMyWidgets(),
    );
  }
}

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
            //Navigator.of(context).pushNamed("/home");
          },
        ),
        ListTile(
          title: Text('Form'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed("/form");
          },
        ),
        ListTile(
          title: Text('Favorites'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
