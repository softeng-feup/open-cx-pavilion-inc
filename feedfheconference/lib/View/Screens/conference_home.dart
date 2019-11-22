import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Model/db.dart';

class ConferenceHomePage extends StatefulWidget {
  final String title = 'Home Page';

  @override
  _ConferenceHomePageState createState() => _ConferenceHomePageState();
}

class _ConferenceHomePageState extends State<ConferenceHomePage>
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

List<Widget> listMyWidgets() {
  var db = Database();
  @override
  List<Widget> widgetsList = new List();

  for(int i = 0; i < db.conferenceList[i].eventIdList.length; i++) {
    Event event = db.eventList[i];
    for(int j = 0; j < event.sessionIdList.length; j++) {
      Session session = db.sessionList[j];
      widgetsList.add(EventBox(session.title, session.room, session.beginTime, session.endTime));
    }
  }

  return widgetsList;
}

class EventBox extends StatelessWidget {
  final String eventTitle = "PX/19";
  final String title;
  final String room;
  final DateAndTime beginTime;
  final DateAndTime endTime;

  EventBox(this.title, this.room, this.beginTime, this.endTime);

  @override
  Widget build(BuildContext context){
    return InkWell(
        onTap: () => print("I Should open an event page!"),
        child: Container(
          color: Colors.grey[100],
          margin: const EdgeInsets.only(bottom: 8.0),
          child: Stack(
            children: [
                      Container(
                      height: 80,
                      margin: const EdgeInsets.only(left: 30, top: 25, right: 30),
                      child: Column(
                        children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(eventTitle + " - " + title, textAlign: TextAlign.left, style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          )
                          ),
                        ),
                        SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(room),
                        ),
                        SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerLeft,
                          //child: Text(beginTime.toString()),
                        ),
                        ],
                      )
                  ),
                  Container(
                    //margin: const EdgeInsets.only(left: 1),
                      child:Align(
                        alignment: Alignment.topLeft,
                        child: Icon(
                          Icons.star,
                          color: Colors.blue[500],
                        ),
                      )
                  ),
          ],
        )
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
              )),
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
