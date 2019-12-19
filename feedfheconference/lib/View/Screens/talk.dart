import 'package:feedfheconference/View/Screens/createForm.dart' as prefix0;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Model/db.dart';
import './common.dart';
import './createForm.dart';
import './form.dart';
import './statistic.dart';
import 'talkRating.dart';

class TalkPage extends StatefulWidget {

  String title;
  final int talkId;
  final String session;
  final String event;
  final String username;


  @override
  TalkPage({Key key, this.event, this.session, this.talkId, this.username})
      : super(key: key) {
    for (int i = 0; i < db.talkList.length; i++) {
      if (this.talkId == db.talkList[i].id){
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
              context, _scrollViewController, widget.event, widget.session, widget.title, widget.talkId),

          drawer: sideDrawer(context, widget.username), // Passed BuildContext in function.
        ));
  }
}

NestedScrollView buildTalkPage(
    BuildContext context,
    ScrollController _scrollViewController,
    String event,
    String session,
    String title,
    int talkId) {
  return new NestedScrollView(
    controller: _scrollViewController,
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        new SliverAppBar(
          title: Column(
              children: <Widget>[
              Text(event),
              Text(session),
              ]
          ),
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

  Talk talk;

  for(int i = 0; i < db.talkList.length; i++)
  {
    if(db.talkList[i].id == talkId)
    {
      talk = db.talkList[i];
   //  print(talk);
      break;
    }
  }

  //Speakers
  var talkSpeakerIDs = talk.speakersId;
  List <Speaker> talkSpeakers = new List(); //Contains all the speakers (object) for current talk

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

  double calculateRating() {

    List<Rate> ratings = new List();
    double soma = 0;

    for (int i = 0; i < db.rateList.length; i++) {
      if (db.rateList[i].talkId == talkId)
        ratings.add(db.rateList[i]);
    }

    for(int i = 0; i < ratings.length; i++) {
      soma += ratings[i].rate;
    }

    return soma /= ratings.length;
  }

  widgetsList.add(
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(children: <Widget> [
        Text("Rating: " + calculateRating().toStringAsFixed(1).toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Icon(Icons.star, color: Colors.amber)
      ])
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
          child: Text('Starts at: ' + timeToString(talk.beginTime), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
      ),
  );

  widgetsList.add(
    Container(
        //color: Colors.green,
        margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
        child: Text('Ends at: ' + timeToString(talk.endTime), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
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
            builder: (BuildContext context){return new FormPage(formId: talk.formId);},
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
            builder: (BuildContext context) => new CreateFormPage(formId: talk.formId),
          );  
          Navigator.of(context).push(route);
          },
        child: Text('Create/Modify Form (Speaker/Organizer only)', style: TextStyle(fontWeight: FontWeight.bold),),
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
            builder: (BuildContext context) => new StatisticsForm(formId: talk.formId, talkName: talk.title),
          );  
          Navigator.of(context).push(route);
          },
        child: Text('Answers/Statistics for the form)', style: TextStyle(fontWeight: FontWeight.bold),),
      )
    )
  );

  widgetsList.add(
    Container(
      margin: const EdgeInsets.only(top:10 ,left: 35, right: 35),
      child: FlatButton(
        color: Colors.blue,
        textColor: Colors.white,
        padding: EdgeInsets.all(8),
        onPressed: () {
          var route = MaterialPageRoute(
            builder: (BuildContext context) => new TalkRating(talkId: talkId)
          );
          Navigator.of(context).push(route);
        },
        child: Text('Rate talk', style: TextStyle(fontWeight: FontWeight.bold))
      ),
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
