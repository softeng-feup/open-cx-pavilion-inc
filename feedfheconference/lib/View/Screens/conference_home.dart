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
  final String username;
  @override
   ConferenceHomePage({Key key, this.conferenceId, this.conferenceName, this.username}): super(key: key);
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
              context, _tabController, _scrollViewController, widget.conferenceName, widget.conferenceId, widget.username),
          drawer: sideDrawer(context, widget.username), // Passed BuildContext in function.
        ));
  }
}


List<Widget> currentPageList(int conferenceId, String username){

  List<Widget> pageList = new List();
  var numberOfDays = controller.numberDaysOfConference(conferenceId);
  DateTime now;

  var conferenceList = controller.getConferenceList();

  for(int i = 0; i < conferenceList.length; i++){
    if(conferenceList[i].id == conferenceId){
      for(int j = 0; j < numberOfDays; j++){
        now = Jiffy(conferenceList[i].beginDate).add(days: j); //2018-07-13 00:00:00.000
        pageList.add(CurrentPage(conferenceId, now, username));
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
    int conferenceId,String username) {
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
      children: currentPageList(conferenceId, username),
      controller: _tabController,
    ),
  );
}

List<Widget> listMyWidgets(int conferenceId, DateTime date, String username) {
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
            widgetsList.add(EventBox_ConfHome(conferenceList[y].name, event.id, event.title, sessionList[i].title, sessionList[i].room, sessionList[i].beginTime, sessionList[i].endTime, talkList, username));
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
  EventBox_ConfHome(String conferenceName, int eventId, String eventTitle, String sessionTitle, String room, DateTime beginTime, DateTime endTime, var talks, String username) : super(conferenceName, eventId, eventTitle, sessionTitle, room, beginTime, endTime, talks, username);

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
                      child:Column(
                          children: [
                            Align(alignment: Alignment.centerLeft, child: Text(talks[i].title)),
                            Align(alignment: Alignment.centerLeft, child: Text(timeToString(talks[i].beginTime) + ' - ' + timeToString(talks[i].endTime))),
                          ]
                      )
                  ),
                  Favorite(talk: talks[i], username: this.username),
                ]
            )
          ),
        color: Colors.white,
        onPressed: () {
          var route = MaterialPageRoute(
            builder: (BuildContext context) => new TalkPage(event: eventTitle,session: sessionTitle, talkId: talks[i].id, username: username,),
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
            color: Colors.grey[200],
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
  var talk;
  final String username;
  List<int> userFavorites = new List();

  @override
  Favorite({Key key, this.talk, this.username}): super(key: key) {
    var userList = controller.getUserList();

    for (var i = 0; i < userList.length; i++) {
      if (userList[i].userName == this.username) {
        this.userFavorites = userList[i].favoriteTalks;
      }
    }
  }

  FavoriteState createState() => new FavoriteState();
}

class FavoriteState extends State<Favorite> {

  _pressed() {
    setState(() {
      if(isFavorite(widget.talk)) {
        widget.userFavorites.remove(widget.talk.id);
      }
      else {
        widget.userFavorites.add(widget.talk.id);
      }
    });
  }

  isFavorite(var t) {
    if(widget.userFavorites.indexOf(t.id) == -1) {
      return false;
    }
    else
      return true;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        icon: Icon(
            isFavorite(widget.talk) ? Icons.star : Icons.star_border,
            color: isFavorite(widget.talk) ? Colors.blue[500] : Colors.grey
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
  final String username;
  @override
  CurrentPage(this.conferenceId, this.date, this.username);
  Widget build(BuildContext context) {
    return new ListView(
      padding: EdgeInsets.zero,
      children: listMyWidgets(conferenceId, date, username),
    );
  }
}

