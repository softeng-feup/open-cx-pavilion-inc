import 'package:feedfheconference/Controller/controller.dart';
import 'package:feedfheconference/Util/Date.dart';
import 'package:feedfheconference/View/Screens/common.dart';
import 'package:feedfheconference/View/Screens/talk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  final String title = 'Favorites';
  final String username;
  @override
  FavoritesPage({Key key, this.username}): super(key: key);
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          body: buildFavoritesPage(context, _tabController, _scrollViewController, widget.title, widget.username),
          drawer: sideDrawer(context, widget.username),
      ));
  }
}

NestedScrollView buildFavoritesPage(BuildContext context, TabController _tabController, ScrollController _scrollViewController, String title, String username) {
  return new NestedScrollView(
    controller: _scrollViewController,
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        new SliverAppBar(
          title: Text(title),
          pinned: true,
          floating: true,
          snap: true,
          forceElevated: innerBoxIsScrolled,
        ),
      ];
    },
    body: new CurrentPage(username),
  );
}

List<Widget> listMyWidgets(String username) {
  @override
  List<Widget> widgetList = new List();

  var conferenceList = controller.getConferenceList();
  var eventList = controller.getEventList();
  var sessionList = controller.getSessionList();
  var talkList = controller.getTalkList();

  List<int> favorites;
  var userList = controller.getUserList();

  for (var i = 0; i < userList.length; i++) {
    if (userList[i].userName == username) {
      favorites = userList[i].favoriteTalks;
    }
  }

  for(int y = 0; y < conferenceList.length; y++){
    for(int i = 0; i < conferenceList[y].eventIdList.length; i++) {
      for(int j = 0; j < eventList.length; j++){
        if(conferenceList[y].eventIdList[i] == eventList[j].id){
          var event = eventList[j];
          for(int h = 0; h < event.sessionIdList.length; h++){
            for(int l = 0; l < sessionList.length; l++){
              if(event.sessionIdList[h] == sessionList[l].id){
                var session = sessionList[l];
                for(int k = 0; k < session.talkIdList.length; k++) {
                  for(int z = 0; z < talkList.length; z++) {
                    if(session.talkIdList[k] == talkList[z].id) {
                        if(favorites.indexOf(talkList[z].id) != -1) {
                          widgetList.add(TalkBox(conferenceList[y].name, event.title, session.title, session.room, talkList[z].id, talkList[z].title, talkList[z].beginTime, talkList[z].endTime));
                        }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  return widgetList;
}


class TalkBox extends StatelessWidget {
  final String conferenceName;
  final String eventTitle;
  final String sessionTitle;
  final String room;
  final int talkId;
  final String title;
  final DateTime beginTime;
  final DateTime endTime;

  TalkBox(this.conferenceName, this.eventTitle, this.sessionTitle, this.room, this.talkId, this.title, this.beginTime, this.endTime);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var route = MaterialPageRoute(
          builder: (BuildContext context) => new TalkPage(event: eventTitle, session: sessionTitle, talkId: talkId),
        );
        Navigator.of(context).push(route);
      },
      child: Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: EdgeInsets.only(bottom: 10),
          child: Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Talk title: " + title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
              ),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Conference: " + conferenceName, textAlign: TextAlign.left, style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                )),
              ),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Session: " + sessionTitle, textAlign: TextAlign.left, style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                )),
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
            ],
          )
      ),
    );
  }
}

class CurrentPage extends StatelessWidget {
  final String username;

  CurrentPage(this.username);
  @override
  Widget build(BuildContext context) {
    return new ListView(
        padding: EdgeInsets.zero,
        children: listMyWidgets(this.username),
    );
  }
}