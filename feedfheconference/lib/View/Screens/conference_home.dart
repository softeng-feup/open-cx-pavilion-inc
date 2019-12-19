import 'package:feedfheconference/Model/db.dart';
import 'package:feedfheconference/Util/Date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './event.dart';
import './talk.dart';
import './common.dart';
import 'package:jiffy/jiffy.dart';
import 'package:feedfheconference/Controller/controller.dart';


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
    var numberOfdays = controller.numberDaysOfConference(widget.conferenceId); // Added
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


List<Widget> currentPageList(int conferenceId){

  List<Widget> pageList = new List();
  var numberOfDays = controller.numberDaysOfConference(conferenceId);
  DateTime now;

  var conferenceList = controller.getConferenceList();

  for(int i = 0; i < conferenceList.length; i++){
    if(conferenceList[i].id == conferenceId){
      for(int j = 0; j < numberOfDays; j++){
        now = Jiffy(conferenceList[i].beginDate).add(days: j); //2018-07-13 00:00:00.000
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
            tabs: controller.getTabList(conferenceId),
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

  var conferenceList = controller.getConferenceList();

  for(int y = 0; y < conferenceList.length; y++){
    if(conferenceList[y].id == conferenceId){
     for(int j = 0; j < conferenceList[y].eventIdList.length; j++){
       var event = controller.getEventFromId(conferenceList[y].eventIdList[j]);
       var sessionList  = controller.sessionListForAEvent(conferenceList[y].eventIdList[j]);

       for(int i = 0; i < sessionList.length; i++){
         if(sessionList[i].beginTime.day == date.day && sessionList[i].beginTime.month == date.month && sessionList[i].beginTime.day == date.day){
         var talkList = controller.talkListForASession(sessionList[i].id);
            widgetsList.add(EventBox_ConfHome(conferenceList[y].name, event.id, event.title, sessionList[i].title, sessionList[i].room, sessionList[i].beginTime, sessionList[i].endTime, talkList));
         }
       }
      }
      break;
    }
  }
  return widgetsList;
}

class EventBox_ConfHome extends EventBox
{
  EventBox_ConfHome(String conferenceName, int eventId, String eventTitle, String sessionTitle, String room, DateTime beginTime, DateTime endTime, List<Talk> talks) : super(conferenceName, eventId, eventTitle, sessionTitle, room, beginTime, endTime, talks);

  @override
  Widget build(BuildContext context) {
    var talkWidgets = List<Widget>();
    for (int i = 0; i < talks.length; i++) {
      talkWidgets.add(RaisedButton(child:
      Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
              children: [
                Expanded(
                    child: Column(
                        children: [
                          Align(alignment: Alignment.centerLeft,
                              child: Text(talks[i].title)),
                          Align(alignment: Alignment.centerLeft,
                              child: Text(
                                  timeToString(talks[i].beginTime) + ' - ' +
                                      timeToString(talks[i].endTime))),
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
            builder: (BuildContext context) =>
            new TalkPage(
                event: eventTitle, session: sessionTitle, talkId: talks[i].id),
          );
          Navigator.of(context).push(route);
        },
      ));
      talkWidgets.add(SizedBox(height: 10));
    }
    return InkWell(
        onTap: () {
          var route = MaterialPageRoute(
            builder: (BuildContext context) =>
            new EventPage(conferenceName: conferenceName, eventId: eventId),
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
                          child: Text(eventTitle + " - " + sessionTitle,
                              textAlign: TextAlign.left, style: TextStyle(
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
                          child: Text(timeToString(beginTime) + ' - ' +
                              timeToString(endTime)),
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

