import 'package:feedfheconference/View/Screens/createForm.dart' as prefix0;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Model/db.dart';
import './common.dart';
import './createForm.dart';
import './Form.dart';


class TalkPage extends StatefulWidget {
  String title;
  final int talkId;
  final Database db;

  @override
  TalkPage({Key key, this.title, this.talkId, this.db})
      : super(key: key) {
    for (int i = 0; i < db.talkList.length; i++) {
      if (this.talkId == db.talkList[i].id) {
        this.title = db.talkList[i].title;
        break;
      }
    }
  }
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
              context, _scrollViewController, widget.title, widget.talkId),

          drawer: sideDrawer(context), // Passed BuildContext in function.
        ));
  }
}

NestedScrollView buildTalkPage(
    BuildContext context,
    ScrollController _scrollViewController,
    String title,
    int talkId) {
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
    body: new CurrentPage(talkId),
  );
}

List<Widget> listMyWidgets(talkId, context) {

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
  var wantedTalkID = talkId; // The Lisp of the prophet for the one true editor (ID only)
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
          var route = MaterialPageRoute(
            builder: (BuildContext context) => new FormPage(),
          );  
          Navigator.of(context).push(route);
          },
        child: Text('Feed our talk!', style: TextStyle(fontWeight: FontWeight.bold),),
      )
    )
  );

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
        onPressed:  () {
          var route = MaterialPageRoute(
            builder: (BuildContext context) => new CreateFormPage(),
          );  
          Navigator.of(context).push(route);
          },
        child: Text('CreateForm', style: TextStyle(fontWeight: FontWeight.bold),),
      )
    )
  );

  return widgetsList;
}

class CurrentPage extends StatelessWidget {
  int talkId;

  @override
  CurrentPage(this.talkId);
  Widget build(BuildContext context) {
    return new ListView(
      padding: EdgeInsets.zero,
      children: listMyWidgets(talkId, context),
    );
  }
}
