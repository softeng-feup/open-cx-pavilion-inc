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
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
                children: [
                  Expanded(
                      child:Column(
                          children: [
                            Align(alignment: Alignment.centerLeft, child: Text(talks[i].title)),
                            Align(alignment: Alignment.centerLeft, child: Text(timeToString(talks[i].beginTime) + ' - ' + timeToString(talks[i].endTime))),
                          ]
                      )
                  ),
                  Favorite(talk: talks[i]),
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

  final int conferenceId;
  final DateTime date;
  @override
  CurrentPage(this.conferenceId, this.date);
  Widget build(BuildContext context) {
    return new ListView(
      padding: EdgeInsets.zero,
      children: listMyWidgets(conferenceId, date),
    );
  }
}

