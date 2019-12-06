import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Model/db.dart';

import './talk.dart';

class EventPage extends StatefulWidget {
 
  String eventTitle;
  final String conferenceName;
  final int eventId;
  String eventAcronym;
  @override
  EventPage({Key key, this.conferenceName, this.eventId})
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
              widget.conferenceName),
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
    String conferenceName) {
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
        new CurrentPageDescription(eventId, eventTitle),
        new CurrentPageSessions(eventId, conferenceName),
      ],
      controller: _tabController,
    ),
  );
}



class SessionBox extends StatelessWidget {
  
  final String sessionTitle;
  final String room;
  final DateTime beginTime;
  final DateTime endTime;
  final List<Talk> talks;
  final String eventTitle;

  SessionBox(this.eventTitle, this.sessionTitle, this.room, this.beginTime, this.endTime, this.talks);

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
              Align(alignment: Alignment.centerLeft, child: Text(timeToString(talks[i].beginTime) + ' - ' + timeToString(talks[i].endTime))),
            ]
          )
      ));
      talkWidgets.add(SizedBox(height: 10));
    }
    return Container(
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
                        child: Text(eventTitle + " - " + sessionTitle, textAlign: TextAlign.left, style: TextStyle(
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
                        child: Text(dateToInvertedString(beginTime) + '     ' +  timeToString(beginTime) + ' - ' + timeToString(endTime)),
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
    );
  }
}


class EventBox extends StatelessWidget {
  final String eventTitle;
  final String sessionTitle;
  final String room;
  final DateTime beginTime;
  final DateTime endTime;
  final List<Talk> talks;
  final String conferenceName;
  int eventId;

  EventBox(this.conferenceName, this.eventId, this.eventTitle, this.sessionTitle, this.room, this.beginTime, this.endTime, this.talks);

  @override
  Widget build(BuildContext context){
    var talkWidgets = List<Widget>();
    for (int i = 0; i < talks.length; i++) {
      talkWidgets.add(RaisedButton(child:
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                Favorite(talk: talks[i]),
                Align(alignment: Alignment.centerLeft, child: Text(talks[i].title)),
                SizedBox(height: 3),
                Align(alignment: Alignment.centerLeft, child: Text(timeToString(talks[i].beginTime) + ' - ' + timeToString(talks[i].endTime))),
              ]
            )
          ),
        color: Colors.white,
        onPressed: () {
          var route = MaterialPageRoute(
            builder: (BuildContext context) => new TalkPage(event: eventTitle,session: sessionTitle, talkId: talks[i].id),
          );
          Navigator.of(context).push(route);
        },
      ));
      talkWidgets.add(SizedBox(height: 10));
    }
    return Container(
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
                        child: Text(eventTitle + " - " + sessionTitle, textAlign: TextAlign.left, style: TextStyle(
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
                        child: Text(timeToString(beginTime) + ' - ' + timeToString(endTime)),
                      ),
                      ExpansionTile(
                           title: Text('Talks'),
                          children: talkWidgets
                      ),
                    ],
                  )
              ),
            ],
        )
    );
  }
}

class Favorite extends StatefulWidget {
  final Talk talk;

  @override
  Favorite({Key key, this.talk}): super(key: key);
  FavoriteState createState() => new FavoriteState();
}

class FavoriteState extends State<Favorite> {

  _pressed() {
    setState(() {
      widget.talk.isFavorite = !widget.talk.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        icon: Icon(
            widget.talk.isFavorite ? Icons.star : Icons.star_border,
            color: widget.talk.isFavorite ? Colors.blue[500] : Colors.grey
        ),
        onPressed: () {
          _pressed();
        }
      ),
    );
  }
}


List<Widget> listMySessions(int eventId, String conferenceName) {

   @override
  List<Widget> widgetsList = new List();
  Event event = getEventFromId(eventId);
  List<Session> sessionList  = sessionListForAEvent(eventId);

  for(int i = 0; i < sessionList.length; i++){
      List<Talk> talkList = talkListForASession(sessionList[i].id);
      widgetsList.add(EventBox(conferenceName, event.id, event.title, sessionList[i].title, sessionList[i].room, sessionList[i].beginTime, sessionList[i].endTime, talkList));
    }  
  return widgetsList;
}
  
List<Widget> eventDescription(int eventId, String eventTitle) {
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

  @override
  CurrentPageDescription(this.eventId, this.eventTitle);
  Widget build(BuildContext context) {
    return new ListView(
      padding: EdgeInsets.zero,
      children: eventDescription(eventId, eventTitle),
    );
  }
}

class CurrentPageSessions extends StatelessWidget {
  int eventId;
  String conferenceName;
  @override
  CurrentPageSessions(this.eventId, this.conferenceName);

  Widget build(BuildContext context) {
    return new ListView(
      padding: EdgeInsets.zero,
      children: listMySessions(eventId, conferenceName),
    );
  }
}

