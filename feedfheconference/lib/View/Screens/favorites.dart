import 'package:feedfheconference/Controller/controller.dart';
import 'package:feedfheconference/View/Screens/common.dart';
import 'package:feedfheconference/View/Screens/talk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  final String title = 'Favorites';

  @override
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
          body: buildFavoritesPage(context, _tabController, _scrollViewController, widget.title),
          drawer: sideDrawer(context),
      ));
  }
}

NestedScrollView buildFavoritesPage(BuildContext context, TabController _tabController, ScrollController _scrollViewController, String title) {
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
    body: new CurrentPage(),
  );
}

List<Widget> listMyWidgets() {
  @override
  List<Widget> widgetList = new List();

  var conferenceList = controller.getConferenceList();
  var eventList = controller.getEventList();
  var sessionList = controller.getSessionList();
  var talkList = controller.getTalkList();

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
                        if(talkList[z].isFavorite) {
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
  @override
  Widget build(BuildContext context) {
    return new ListView(
        padding: EdgeInsets.zero,
        children: listMyWidgets()
    );
  }
}