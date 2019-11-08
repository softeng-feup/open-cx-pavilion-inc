import 'package:flutter/material.dart';
import '../../Model/db.dart';

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

NestedScrollView buildHomePage(BuildContext context, TabController _tabController,
    ScrollController _scrollViewController, String title) {
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
          bottom: new TabBar(
            tabs: <Tab>[
              new Tab(text: "Tab 1"),
              new Tab(text: "Tab 2"),
            ],
            controller: _tabController,
          ),
        ),
      ];
    },
    body: new TabBarView(
      children: <Widget>[
        new CurrentPage(),
        new CurrentPage(),
      ],
      controller: _tabController,
    ),
  );
}

List<Widget> listMyWidgets(){
  var db = Database();
  @override
  List<Widget> widgetsList = new List();

    for (int i = 0; i < db.sessions.length; i++){
      widgetsList.add(EventBox(db.sessions[i].title, db.sessions[i].description, db.sessions[i].speaker, db.sessions[i].room, db.sessions[i].time));
    }

  return widgetsList;
}


class EventBox extends StatelessWidget {
  final String title;
  final String description;
  final String speaker;
  final String room;
  final String time;
  EventBox(this.title, this.description, this.speaker, this.room, this.time);
  
  @override
  Widget build(BuildContext context){
    return Container(
          decoration: BoxDecoration(
    border: Border.all(color: Colors.redAccent)
  ),
          padding: const EdgeInsets.all(32),
          child: Row(
            children: [
              Expanded(
                /*1*/
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*2*/
                    Container(
                      decoration: BoxDecoration(
    border: Border.all(color: Colors.blueAccent)
  ),
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              /*3*/
              Icon(
                Icons.star,
                color: Colors.red[500],
              ),
            ],
          )
    );
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

/*

class CurrentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      padding: EdgeInsets.zero,
      children: List.generate(10, (index) {
        return 
        );
      }),
    );
  }
}
*/
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
              )
          ),
        ),
        ListTile(
          title: Text('Home Page'),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).pushNamed("/home");
          },
        ),
        ListTile(
          title: Text('Form'),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).pushNamed("/form");
          },
        ),
        ListTile(
          title: Text('Favorites'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
