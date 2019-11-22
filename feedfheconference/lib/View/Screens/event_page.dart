import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Model/db.dart';

class EventPage extends StatefulWidget {
 
  String eventTitle;
  final String conferenceName;
  final int eventId;
  String eventAcronym;
  final Database db;
  @override
  EventPage({Key key, this.conferenceName, this.eventId, this.db})
      : super(key: key) {
    for (int i = 0; i < db.eventList.length; i++) {
      if (this.eventId == db.eventList[i].id) {
        this.eventTitle = db.eventList[i].title;
        this.eventAcronym = db.eventList[i].acronym;
        break;
      }
    }
  }
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage>
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
              context,
              _tabController,
              _scrollViewController,
              widget.eventAcronym,
              widget.eventTitle,
              widget.eventId,
              widget.conferenceName,
              widget.db),
        ));
  }
}

NestedScrollView buildHomePage(
    BuildContext context,
    TabController _tabController,
    ScrollController _scrollViewController,
    String eventAcronym,
    String eventTitle,
    int eventId,
    String conferenceName,
    Database db) {
  return new NestedScrollView(
    controller: _scrollViewController,
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        new SliverAppBar(
          title: new Text(conferenceName + ' - ' + eventAcronym),
          pinned: true,
          floating: true,
          snap: true,
          forceElevated: innerBoxIsScrolled,
          bottom: new TabBar(
            tabs: <Tab>[
              new Tab(text: "Description"),
              new Tab(text: "Sessions"),
            ],
            controller: _tabController,
          ),
        ),
      ];
    },
    body: new TabBarView(
      children: <Widget>[
        new CurrentPageDescription(eventId, eventTitle, db),
        new CurrentPageSessions(eventId, eventTitle, db),
      ],
      controller: _tabController,
    ),
  );
}

List<Widget> listMyWidgets(int conferenceId) {
  var db = Database();
  @override
  List<Widget> widgetsList = new List();
  print("merda\n");
  print(conferenceId);
  print(conferenceId);
  print(conferenceId);
  print(conferenceId);
  print("merda\n");

  for (int y = 0; y < db.conferenceList.length; y++) {
    if (db.conferenceList[y].id == conferenceId) {
      for (int i = 0; i < db.conferenceList[y].eventIdList.length; i++) {
        for (int j = 0; j < db.eventList.length; j++) {
          if (db.conferenceList[y].eventIdList[i] == db.eventList[j].id) {
            Event event = db.eventList[j];
            for (int h = 0; h < event.sessionIdList.length; h++) {
              for (int l = 0; l < db.sessionList.length; l++) {
                if (event.sessionIdList[h] == db.sessionList[l].id) {
                  Session session = db.sessionList[l];
                  widgetsList.add(EventBox(event.title, session.title,
                      session.room, session.beginTime, session.endTime));
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

  EventBox(
      this.eventTitle, this.title, this.room, this.beginTime, this.endTime);

  @override
  Widget build(BuildContext context) {
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
                          child: Text(eventTitle + " - " + title,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
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
                    )),
                Container(
                    //margin: const EdgeInsets.only(left: 1),
                    child: Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.star,
                    color: Colors.blue[500],
                  ),
                )),
              ],
            )));
  }
}

List<Widget> eventDescription(int eventId, String eventTitle, Database db) {
  @override
  List<Widget> widgetsList = new List();
  var description;

  for (int i = 0; i < db.eventList.length; i++) {
    if (db.eventList[i].id == eventId) {
      description = db.eventList[i].description;
      break;
    }
  }

  widgetsList.add(Container(
      margin: const EdgeInsets.only(left: 30, top: 25, right: 30),
      child: Text(
        eventTitle,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
      )));
  widgetsList.add(Container(
      margin: const EdgeInsets.only(left: 30, top: 25, right: 30),
      child: Text(
        description,
        textAlign: TextAlign.justify,
        style: TextStyle(
            fontSize: 20, color: Colors.black),
      )));
  return widgetsList;
}


class CurrentPageDescription extends StatelessWidget {
  int eventId;
  String eventTitle;
  Database db;
  @override
  CurrentPageDescription(this.eventId, this.eventTitle, this.db);
  Widget build(BuildContext context) {
    return new ListView(
      padding: EdgeInsets.zero,
      children: eventDescription(eventId, eventTitle, db),
    );
  }
}

class CurrentPageSessions extends StatelessWidget {
  int conferenceId;
  String eventTitle;
  Database db;
  @override
  CurrentPageSessions(this.conferenceId, this.eventTitle, this.db);

  Widget build(BuildContext context) {
    return new ListView(
      padding: EdgeInsets.zero,
      children: listMyWidgets(conferenceId),
    );
  }
}

