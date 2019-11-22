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
          body: buildEventPage(
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

NestedScrollView buildEventPage(
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
      children: null
    );
  }
}

