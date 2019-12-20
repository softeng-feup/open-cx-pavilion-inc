import 'package:feedfheconference/Util/Date.dart';
import 'package:flutter/material.dart';
import 'package:feedfheconference/Controller/controller.dart';
import './conference_home.dart';
import './common.dart';

class HomePage extends StatefulWidget {
  final String title = 'Home Page';

  final String username;

  @override
  HomePage({Key key, this.username}): super(key: key);
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
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
          body: buildHomePage(
              context, _tabController, _scrollViewController, widget.title, widget.username),

          drawer: sideDrawer(context, widget.username), // Passed BuildContext in function.
        ));
  }
}

NestedScrollView buildHomePage(
    BuildContext context,
    TabController _tabController,
    ScrollController _scrollViewController,
    String title, String username) {
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

  controller.sortConferenceList();
  controller.sortSessionList();
  controller.sortTalkList();

  @override
  List<Widget> widgetsList = new List();

  widgetsList.add(Text(
    'Available Conferences',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
  ));

  var conferenceList = controller.getConferenceList();
  for (int i = 0; i < conferenceList.length; i++) {
    widgetsList.add(EventBox(
        conferenceList[i].id,
        conferenceList[i].name,
        conferenceList[i].place,
        conferenceList[i].beginDate,
        conferenceList[i].endDate,
        username));
  }

  //for (int i = 0; i < db.sessionList.length; i++) {}

  return widgetsList;
}

class EventBox extends StatelessWidget {
  String name;
  String place;
  DateTime beginDate;
  DateTime endDate;
  int conferenceId;
  String username;
  EventBox(
      this.conferenceId, this.name, this.place, this.beginDate, this.endDate, this.username);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          var route = MaterialPageRoute(
            builder: (BuildContext context) => new ConferenceHomePage(
                conferenceId: conferenceId, conferenceName: name, username: username,),
          );
          Navigator.of(context).push(route);
        }, // handle your onTap here
        child: Container(
            decoration: new BoxDecoration(
                color: Colors.blueGrey[300],
                borderRadius: new BorderRadius.only(
                    bottomLeft: const Radius.circular(30.0),
                    bottomRight: const Radius.circular(30.0),
                    topLeft: const Radius.circular(30.0),
                    topRight: const Radius.circular(30.0))),
            margin: const EdgeInsets.only(top: 10.0),
            padding: const EdgeInsets.only(top: 10.0),
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  //color: Colors.green[200],
                  //width: 215,
                  width: MediaQuery.of(context).size.width - 145,
                  child: Column(
                    children: <Widget>[
                      Text(
                        name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 5),
                      Text(
                        place,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 5),
                      Text(
                          dateToInvertedString(beginDate) +
                              ' <-> ' +
                              dateToInvertedString(endDate),
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  ),
                ),
              ],
            )));
  }
}

class CurrentPage extends StatelessWidget {
  @override
  final String username;

  CurrentPage(this.username);

  Widget build(BuildContext context) {
    return new ListView(
      padding: EdgeInsets.zero,
      children: listMyWidgets(username),
    );
  }
}
