import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Model/db.dart';

class ConferenceHomePage extends StatefulWidget {
  final String title = 'Home Page';
  final int conferenceId;
  @override
   ConferenceHomePage({Key key, this.conferenceId}): super(key: key);
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
              context, _tabController, _scrollViewController, widget.title,  widget.conferenceId),
          drawer: sideDrawer(context), // Passed BuildContext in function.
        ));
  }
}

NestedScrollView buildHomePage(
    BuildContext context,
    TabController _tabController,
    ScrollController _scrollViewController,
    String title, int conferenceId) {
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
        new CurrentPage(conferenceId),
        new CurrentPage(conferenceId),
      ],
      controller: _tabController,
    ),
  );
}

List<Widget> listMyWidgets(int conferenceId) {
  var db = Database();
  @override
  List<Widget> widgetsList = new List();
  
  for(int y = 0; y < db.conferenceList.length; y++){
    if(db.conferenceList[y].id == conferenceId){
      for(int i = 0; i < db.conferenceList[y].eventIdList.length; i++) {
        for(int j = 0; j < db.eventList.length; j++){
          if(db.conferenceList[y].eventIdList[i] == db.eventList[j].id){
            Event event = db.eventList[j];
            for(int h = 0; h < event.sessionIdList.length; h++){
              for(int l = 0; l < db.sessionList.length; l++){
                if(event.sessionIdList[h] == db.sessionList[l].id){
                  Session session = db.sessionList[l];
                  List<Talk> talks = new List();
                  for(int k = 0; k < session.talkIdList.length; k++) {
                    for(int z = 0; z < db.talkList.length; z++) {
                      if(session.talkIdList[k] == db.talkList[z].id) {
                        Talk talk = db.talkList[z];
                        talks.add(talk);
                      }
                    }
                  }
                  widgetsList.add(EventBox(event.title, session.title, session.room, session.beginTime, session.endTime, talks));
                }
              }
            }
          }
        }
      }
      break;
    }
  }
  return widgetsList;
}

class EventBox extends StatelessWidget {
  final String eventTitle;
  final String title;
  final String room;
  final DateAndTime beginTime;
  final DateAndTime endTime;
  final List<Talk> talks;

  EventBox(this.eventTitle,this.title, this.room, this.beginTime, this.endTime, this.talks);

  @override
  Widget build(BuildContext context){
    var talkWidgets = List<Widget>();
    for (int i = 0; i < talks.length; i++) {
      talkWidgets.add(Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Align(alignment: Alignment.centerLeft, child: Text(talks[i].title)),
              SizedBox(height: 3),
              Align(alignment: Alignment.centerLeft, child: Text(talks[i].beginTime.timeToString() + ' - ' + talks[i].endTime.timeToString()))
            ]
          )
      ));
      talkWidgets.add(SizedBox(height: 10));
    }
    return InkWell(
        onTap: () => print("I Should open an event page!"),
        child: Container(
          color: Colors.grey[100],
          margin: const EdgeInsets.only(bottom: 8.0),
          child: Stack(
            children: [
              Container(
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
                        child: Text(beginTime.time.timeToString() + ' - ' + endTime.time.timeToString()),
                      ),
                      ExpansionTile(
                          title: Text('Talks'),

                          children: talkWidgets
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

  int conferenceId;
  @override
  CurrentPage(this.conferenceId);
  Widget build(BuildContext context) {
    return new ListView(
      padding: EdgeInsets.zero,
      children: listMyWidgets(conferenceId),
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
