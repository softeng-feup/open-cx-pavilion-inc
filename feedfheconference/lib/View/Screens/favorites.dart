import 'package:feedfheconference/View/Screens/common.dart';
import 'package:feedfheconference/View/Screens/talk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Model/db.dart';

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
  List<int> favorites;

  for (var i = 0; i < db.userList.length; i++) {
    if (db.userList[i].userName == username) {
      favorites = db.userList[i].favoriteTalks;
    }
  }

  for(int y = 0; y < db.conferenceList.length; y++){
    for(int i = 0; i < db.conferenceList[y].eventIdList.length; i++) {
      for(int j = 0; j < db.eventList.length; j++){
        if(db.conferenceList[y].eventIdList[i] == db.eventList[j].id){
          Event event = db.eventList[j];
          for(int h = 0; h < event.sessionIdList.length; h++){
            for(int l = 0; l < db.sessionList.length; l++){
              if(event.sessionIdList[h] == db.sessionList[l].id){
                Session session = db.sessionList[l];
                for(int k = 0; k < session.talkIdList.length; k++) {
                  for(int z = 0; z < db.talkList.length; z++) {
                    if(session.talkIdList[k] == db.talkList[z].id) {
                        if(favorites.indexOf(db.talkList[z].id) != -1) {
                          widgetList.add(EventBox(db.conferenceList[y].name, event.title, session.title, session.room, db.talkList[z].id, db.talkList[z].title, db.talkList[z].beginTime, db.talkList[z].endTime));
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


class EventBox extends StatelessWidget {
  final String conferenceName;
  final String eventTitle;
  final String sessionTitle;
  final String room;
  final int talkId;
  final String title;
  final DateTime beginTime;
  final DateTime endTime;

  EventBox(this.conferenceName, this.eventTitle, this.sessionTitle, this.room, this.talkId, this.title, this.beginTime, this.endTime);

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
        color: Colors.grey[100],
        child: Stack(
          children: [
            Container(
                margin: const EdgeInsets.all(20),
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
                      )
                      ),
                    ),
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Session: " + sessionTitle, textAlign: TextAlign.left, style: TextStyle(
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
                      child: Text(beginTime.hour.toString() + ':' + beginTime.minute.toString() + ' - ' + endTime.hour.toString() + ':' + endTime.minute.toString()),
                    ),
                  ],
                )
            )
          ],
        ),
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
        children: listMyWidgets(this.username)
    );
  }
}