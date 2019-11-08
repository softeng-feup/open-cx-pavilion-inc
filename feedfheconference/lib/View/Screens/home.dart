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

  for (int i = 0; i < db.sessions.length; i++) {
    widgetsList.add(EventBox(db.sessions[i].title, db.sessions[i].description,
        db.sessions[i].speaker, db.sessions[i].room + ' ' + db.sessions[i].time));
  }

  return widgetsList;
}

class EventBox extends StatelessWidget {
  final String title;
  final String description;
  final String speaker;
  final String roomAndTime;

  EventBox(this.title, this.description, this.speaker, this.roomAndTime);

  @override
  Widget build(BuildContext context){
    return Container(
        color: Colors.grey[100],
        margin: const EdgeInsets.only(bottom: 8.0),
        child: Stack(
          children: [
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
            Container(
              margin: const EdgeInsets.only(left: 20, top: 20),
              //color: Colors.green[200],
              //width: 215,
              width: MediaQuery.of(context).size.width - 145,
              child: Column(
                children: <Widget>[

                  Text(title, textAlign: TextAlign.left, style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),),
                  Text(speaker),
                  Text(roomAndTime),
                  ExpansionTile(
                    title: Text('Description'),
                    children: <Widget>[
                      Text(description,
                          style: TextStyle(
                              fontSize: 13,
                              //fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic))
                    ],)
                ],
              ),),
            Align(
              alignment: Alignment.topRight,
              //margin: const EdgeInsets.only(left: 2),
              //decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              child: Container(
                margin: const EdgeInsets.only(right: 2, top: 20),
                //width: MediaQuery.of(context).size.width / 3,
                width: 120,
                //height: MediaQuery.of(context).size.height / 8,
                height: 85,
                decoration: BoxDecoration(
                  border: Border.all(width: 3.0),
                  borderRadius: BorderRadius.all(
                      Radius.circular(12) //         <--- border radius here
                  ),
                  image: DecorationImage(
                      image: AssetImage("images/face.jpg"), fit: BoxFit.cover),
                ),
              ),
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
