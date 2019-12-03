import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Model/db.dart';
import './event.dart';
import './talk.dart';
import './common.dart';
import 'package:jiffy/jiffy.dart';


class ConferenceHomePage extends StatefulWidget {
  final String conferenceName;
  final int conferenceId;
  @override
   ConferenceHomePage({Key key, this.conferenceId, this.conferenceName}): super(key: key);
  _ConferenceHomePageState createState() => _ConferenceHomePageState();
}

int numberDaysOfConference(int conferenceId){

  DateTime begin;
  DateTime end;

   for(int i = 0; i < db.conferenceList.length; i++){
    if(conferenceId == db.conferenceList[i].id){
      begin = db.conferenceList[i].beginDate;
      end = db.conferenceList[i].endDate;
      break;
    }
  }

  Duration difference = end.difference(begin);
  return  (difference.inDays + 1);
}

class _ConferenceHomePageState extends State<ConferenceHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;
  
  @override
  Widget build(BuildContext context) {
    var numberOfdays = numberDaysOfConference(widget.conferenceId); // Added
    return DefaultTabController(
        // Added
        length: numberOfdays, // Added
        initialIndex: 0, //Added
        child: Scaffold(
          body: buildConferencePage(
              context, _tabController, _scrollViewController, widget.conferenceName, widget.conferenceId),
          drawer: sideDrawer(context), // Passed BuildContext in function.
        ));
  }
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

List<Tab> tabList(int conferenceId){

  List<Tab> tList = new List();
  var numberOfDays = numberDaysOfConference(conferenceId);
  DateTime now;
  Conference conference;
  for(int i = 0; i < db.conferenceList.length; i++){
    if(db.conferenceList[i].id == conferenceId){
      conference = db.conferenceList[i];
      for(int j = 0; j < numberOfDays; j++){
        now = Jiffy(conference.beginDate).add(days: j); //2018-07-13 00:00:00.000
        var day = now.day;
        var month = monthOfTheYear(now);
        tList.add(Tab(text: "$day/$month"));
      }
      break;
    }
  }
  return tList;
}

List<Widget> currentPageList(int conferenceId){

  List<Widget> pageList = new List();
  var numberOfDays = numberDaysOfConference(conferenceId);
  DateTime now;
  Conference conference;
  for(int i = 0; i < db.conferenceList.length; i++){
    if(db.conferenceList[i].id == conferenceId){
      conference = db.conferenceList[i];
      for(int j = 0; j < numberOfDays; j++){
        now = Jiffy(conference.beginDate).add(days: j); //2018-07-13 00:00:00.000
        pageList.add(CurrentPage(conferenceId, now));
      }
      break;
    }
  }
  return pageList;
}

List<Talk> talkListForASession(int sessionId){

  List<Talk> talkList = new List();
  for(int i = 0; i < db.sessionList.length; i++){
    if(db.sessionList[i].id == sessionId){
      for(int j = 0; j < db.sessionList[i].talkIdList.length; j++){ 
        for(int h = 0; h < db.talkList.length; h++){
          if(db.sessionList[i].talkIdList[j] == db.talkList[h].id){
            talkList.add(db.talkList[h]);
          }
        }
      }
      break;
    }
  }

  talkList.sort((a, b) =>
      (dateAndTimeToString(b.beginTime).compareTo(dateAndTimeToString(a.beginTime))));

  return talkList;
} 

List<Session> sessionListForAEvent(int eventId){

  List<Session> sessionList = new List();
  Event event = getEventFromId(eventId);

  for(int j = 0; j < event.sessionIdList.length; j++){ 
    for(int h = 0; h < db.sessionList.length; h++){
      if(event.sessionIdList[j] == db.sessionList[h].id){
        sessionList.add(db.sessionList[h]);
      }
    }
  }
  sessionList.sort((a, b) =>
      (dateAndTimeToString(b.beginTime).compareTo(dateAndTimeToString(a.beginTime))));

  return sessionList;
}

Event getEventFromId(int eventId){

  Event event;

  for(int i = 0; i < db.eventList.length; i++){
    if(db.eventList[i].id == eventId){
      event = db.eventList[i];
      break;
    }
  }
  return event;
}

NestedScrollView buildConferencePage(
    BuildContext context,
    TabController _tabController,
    ScrollController _scrollViewController,
    String title,
    int conferenceId) {
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
            tabs: tabList(conferenceId),
            controller: _tabController,
            isScrollable: true,
            labelPadding: EdgeInsets.symmetric(horizontal: 20.0),
          ),
        ),
      ];
    },
    body: new TabBarView(
      children: currentPageList(conferenceId),
      controller: _tabController,
    ),
  );
}

List<Widget> listMyWidgets(int conferenceId, DateTime date) {
  @override
  List<Widget> widgetsList = new List();
    
  for(int y = 0; y < db.conferenceList.length; y++){
    if(db.conferenceList[y].id == conferenceId){
     for(int j = 0; j < db.conferenceList[y].eventIdList.length; j++){
       Event event = getEventFromId(db.conferenceList[y].eventIdList[j]);
       List<Session> sessionList  = sessionListForAEvent(db.conferenceList[y].eventIdList[j]);

       for(int i = 0; i < sessionList.length; i++){
         if(sessionList[i].beginTime.day == date.day && sessionList[i].beginTime.month == date.month && sessionList[i].beginTime.day == date.day){
         List<Talk> talkList = talkListForASession(sessionList[i].id);
            widgetsList.add(EventBox(db.conferenceList[y].name, event.id, event.title, sessionList[i].title, sessionList[i].room, sessionList[i].beginTime, sessionList[i].endTime, talkList));
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
                Align(alignment: Alignment.centerLeft, child: Text(timeToString(talks[i].beginTime) + '0 - ' + timeToString(talks[i].endTime))),
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
    return InkWell(
        onTap: () {
          var route = MaterialPageRoute(
            builder: (BuildContext context) => new EventPage(conferenceName:  conferenceName, eventId: eventId),
          );  
          Navigator.of(context).push(route);
          },
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
                        child: Text(timeToString(beginTime) + '0 - ' + timeToString(endTime)),
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

class CurrentPage extends StatelessWidget {

  int conferenceId;
  DateTime date;
  @override
  CurrentPage(this.conferenceId, this.date);
  Widget build(BuildContext context) {
    return new ListView(
      padding: EdgeInsets.zero,
      children: listMyWidgets(conferenceId, date),
    );
  }
}

