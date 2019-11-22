import 'package:flutter/material.dart';
import '../../Model/db.dart';

class TalkPage extends StatefulWidget {
  final String title = 'Talk details';

  @override
  _TalkPageState createState() => _TalkPageState();
}

class _TalkPageState extends State<TalkPage>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollViewController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        // Added
        length: 2, // Added
        initialIndex: 0, //Added
        child: Scaffold(
          body: buildTalkPage(
              context, _scrollViewController, widget.title),

          drawer: sideDrawer(context), // Passed BuildContext in function.
        ));
  }
}

NestedScrollView buildTalkPage(
    BuildContext context,
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
  var db = Database();

  //Conference
  var wantedConferenceID = 1; //Programming 2019 (ID only)
  var conferencesList = db.conferenceList;
  var conference; //Object, not just ID

  //Searches for the conference with the wanted ID
  for(int i = 0; i < conferencesList.length; i++)
    {
      if(conferencesList[i].id == wantedConferenceID)
        {
          conference = conferencesList[i];
          break;
        }
    }

  //Event
  var wantedEventID = 1; //ELS 2019 (ID only)
  var eventList = db.eventList;
  var event;

  for(int i = 0; i < eventList.length; i++)
    {
      if(eventList[i].id == wantedEventID)
        {
          event = eventList[i];
          break;
        }
    }

  //Session
  var wantedSessionID = 1; // Paganini (ID only)
  var sessionList = db.sessionList;
  var session;

  for(int i = 0; i < sessionList.length; i++)
  {
    if(sessionList[i].id == wantedSessionID)
    {
      session = sessionList[i];
      break;
    }
  }

  //Talk
  var wantedTalkID = 1; // The Lisp of the prophet for the one true editor (ID only)
  var talksList = db.talkList;
  Talk talk;

  for(int i = 0; i < talksList.length; i++)
  {
    if(talksList[i].id == wantedTalkID)
    {
      talk = talksList[i];
      break;
    }
  }

  //Speakers
  var talkSpeakerIDs = talk.speakersId;
  List <Speaker> talkSpeakers = new List(); //Cointains all the speakers (object) for current talk

  for(int i = 0; i < talkSpeakerIDs.length; i++)
    {
      for(int y = 0; y < db.speakerList.length; y++)
        {
          if(db.speakerList[y].id == talkSpeakerIDs[i])
            {
              talkSpeakers.add(db.speakerList[y]);
              break;
            }
        }
    }

  @override
  List<Widget> widgetsList = new List();

  //Title
  widgetsList.add(
    Container(
        //color: Colors.green,
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 15),
        child: Text( talk.title,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      )
    )
  );

  //Speakers
  widgetsList.add(
    Container(
      margin: const EdgeInsets.only(top: 20, bottom: 5, left: 5),
      child: Text('Speakers: ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)
    )
  );

  for(int i = 0; i < talkSpeakers.length; i++)
    {
      //Info to be added about each Speaker
      widgetsList.add(
        Container(
          //color: Colors.green,
          margin: const EdgeInsets.all(10),
          height: 48,
          child:
                Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(talkSpeakers[i].name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Degree: ' + talkSpeakers[i].degree, style: TextStyle(fontSize: 13),),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Field Expertize: ' + talkSpeakers[i].fieldOfExpertize, style: TextStyle(fontSize: 13),),
                    ),

                    //Speaker Image Goes Here

                  ],
                )
        )
      );
    }

  //Duration
  widgetsList.add(
      Container(
          //color: Colors.green,
          margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: Text('Starts at: ' + talk.beginTime.timeToString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
      ),
  );
  widgetsList.add(
    Container(
        //color: Colors.green,
        margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
        child: Text('Ends at: ' + talk.endTime.timeToString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
    ),
  );

  //About this talk
  widgetsList.add(
      Container(
        //color: Colors.green,
          margin: const EdgeInsets.only(top: 10, bottom: 5, left: 5),
          child: Text('About this talk:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
      )
  );


  //Description
  widgetsList.add(
      Container(
          //color: Colors.green,
          margin: const EdgeInsets.only(top: 5, bottom: 5, left: 8, right: 8),
          child: Text(talk.description, style: TextStyle(fontSize: 15),)
      )
  );

  //Form button
  widgetsList.add(
    Container(
      margin: const EdgeInsets.only(top:10 ,left: 35, right: 35),
      child: FlatButton(
        color: Colors.blue,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.blueAccent,
        onPressed: () {
          //Navigator.of(context).pop();
          //Navigator.of(context).pushReplacementNamed("/form");
          print('I Should lead to the form of this talk');
        },
        child: Text('Feed our talk!', style: TextStyle(fontWeight: FontWeight.bold),),
      )
    )
  );

  return widgetsList;
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

Drawer sideDrawer(BuildContext context) {
  return new Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the drawer if there isn't enough vertical
    // space to fit everything.
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.12,
          child: DrawerHeader(
              child: Text('Menu', style: TextStyle(color: Colors.white)),
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Color.fromRGBO(3, 44, 115, 1),
              )),
        ),
        ListTile(
          title: Text('Home Page'),
          onTap: () {
            Navigator.of(context).pop();
            //Navigator.of(context).pushNamed("/home");
          },
        ),
        ListTile(
          title: Text('Form'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed("/form");
          },
        ),
        ListTile(
          title: Text('Favorites'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
