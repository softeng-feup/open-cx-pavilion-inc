
import 'package:flutter/material.dart';
import '../../Model/db.dart';
import './conference_home.dart';
import './common.dart';

class HomePage extends StatefulWidget {
  final String title = 'Home Page';

  @override
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
              context, _tabController, _scrollViewController, widget.title),

          drawer: sideDrawer(context), // Passed BuildContext in function.
        ));
  }
}

NestedScrollView buildHomePage(
    BuildContext context,
    TabController _tabController,
    ScrollController _scrollViewController,
    String title) {
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
        ),
      ];
    },
    body: new CurrentPage(),
  );
}

List<Widget> listMyWidgets() {


  db.conferenceList.sort((a, b) =>
      (dateToString(a.beginDate).compareTo(dateToString(b.beginDate))));

  db.sessionList.sort((a, b) =>
      (dateToString(a.beginTime).compareTo(dateToString(b.beginTime))));


  db.talkList.sort((a, b) =>
      (dateToString(a.beginTime).compareTo(dateToString(b.beginTime))));

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

  for (int i = 0; i < db.conferenceList.length; i++) {
    widgetsList.add(EventBox(
        db.conferenceList[i].id,
        db.conferenceList[i].name,
        db.conferenceList[i].place,
        db.conferenceList[i].beginDate,
        db.conferenceList[i].endDate));
  }

  for (int i = 0; i < db.sessionList.length; i++) {}

  return widgetsList;
}

class EventBox extends StatelessWidget {
  String name;
  String place;
  DateTime beginDate;
  DateTime endDate;
  int conferenceId;
  EventBox(this.conferenceId,this.name, this.place, this.beginDate, this.endDate);

  @override
  Widget build(BuildContext context) {
    return InkWell(
          onTap: () {

          var route = MaterialPageRoute(
            builder: (BuildContext context) => new ConferenceHomePage(conferenceId: conferenceId, conferenceName: name,),
          );  
          Navigator.of(context).push(route);
          }, // handle your onTap here
          child: Container(
              color: Color.fromARGB(60, 0, 0, 255),
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
                                color: Colors.white),
                          ),
                          SizedBox(height: 5),
                          Text(
                            place,
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          SizedBox(height: 5),
                          Text(
                              dateToInvertedString(beginDate) +
                                  ' <-> ' +
                                  dateToInvertedString(endDate),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                        ],
                      ),
                    ),
                ],
              )));
  }
}

class CurrentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      padding: EdgeInsets.zero,
      children: listMyWidgets(),
    );
  }
}

