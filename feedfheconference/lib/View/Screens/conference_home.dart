import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Model/db.dart';
import './event.dart';
import './talk.dart';
import './common.dart';

class ConferenceHomePage extends StatefulWidget {
  final String conferenceName;
  final String title ="lol";
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
    return DefaultTabController(
        // Added
        length: 6, // Added
        initialIndex: 0, //Added
        child: Scaffold(
          body: buildConferencePage(
              context, _tabController, _scrollViewController, widget.conferenceName,  widget.conferenceId),
          drawer: sideDrawer(context), // Passed BuildContext in function.
        ));
  }
}

List<Tab> tabList(int conferenceId){

     List<Tab> tList = new List();
  var numberOfDays;
  for(int i = 0; i < db.conferenceList.length; i++){
    if(db.conferenceList[i].id == conferenceId){
      Conference conference = db.conferenceList[i];
      tList.add(Tab(text: "22/1"));
      tList.add(Tab(text: "23/1"));
      tList.add(Tab(text: "24/1"));
       tList.add(Tab(text: "25/1"));
      tList.add(Tab(text: "26/1"));
      tList.add(Tab(text: "27/1"));


      break;
    }
  }
  return tList;

            


}

NestedScrollView buildConferencePage(
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
            tabs: tabList(conferenceId),
            controller: _tabController,
          ),
        ),
      ];
    },
    body: new TabBarView(
      children: <Widget>[
        new CurrentPage(conferenceId),
        new CurrentPage(conferenceId),
        new CurrentPage(conferenceId),
        new CurrentPage(conferenceId),
        new CurrentPage(conferenceId),
        new CurrentPage(conferenceId),
      ],
      controller: _tabController,
    ),
  );
}

List<Widget> listMyWidgets(int conferenceId) {
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
               
                  widgetsList.add(EventBox(db.conferenceList[y].name, event.id, event.title, session.title, session.room, session.beginTime, session.endTime, talks));
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
  final String sessionTitle;
  final String room;
  final DateAndTime beginTime;
  final DateAndTime endTime;
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
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Align(alignment: Alignment.centerLeft, child: Text(talks[i].title)),
                SizedBox(height: 3),
                Align(alignment: Alignment.centerLeft, child: Text(talks[i].beginTime.timeToString() + ' - ' + talks[i].endTime.timeToString()))
              ]
            )
          ),
        onPressed: () {
          var route = MaterialPageRoute(
            builder: (BuildContext context) => new TalkPage(title: talks[i].title, talkId: talks[i].id, db: db),
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

