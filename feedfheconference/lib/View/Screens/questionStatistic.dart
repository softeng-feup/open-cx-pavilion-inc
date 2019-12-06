import 'dart:ffi';
import 'package:flutter/material.dart';
import '../../Model/db.dart';
import './common.dart';
// Create a Form widget.

class QuestionStatisticsPage extends StatefulWidget {
  final String title = 'Form Page';
  final int questionId;
  final String talkName;
  final int questionIndex;

  @override
  QuestionStatisticsPage(
      {Key key, this.questionIndex, this.talkName, this.questionId})
      : super(key: key);
  QuestionStatisticsState createState() {
    return QuestionStatisticsState();
  }
}


List<Widget> listQuestionStatistics(BuildContext context, var questionId) {
  @override
  List<Widget> widgetsList = new List();

  String questionText = getQuestionText(questionId);
  QuestionType questionType = getQuestionType(questionId);

  if (questionType == QuestionType.checkBox ||
      questionType == QuestionType.radioButton) {
    List<String> questionSubText = getSubQuestionText(questionId);
    QuestionType type = getQuestionType(questionId);
    if (type == QuestionType.textBox) {
      widgetsList.add(Text(questionText,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)));
    }
    widgetsList.add(SizedBox(
      height: 10,
    ));
    for (int i = 0; i < questionSubText.length; i++) {
      widgetsList.add(Text(
          questionSubText[i] +
              " " +
              questionAnswerPercentage(questionId, questionSubText[i]) +
              "%",
          style: TextStyle(fontWeight: FontWeight.bold)));
      widgetsList.add(SizedBox(
        height: 10,
      ));
    }
  } else {
    widgetsList.add(Text(questionText,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)));
    widgetsList.add(SizedBox(
      height: 10,
    ));
    widgetsList.add(Text(
        'Percentage of people who answered this question : ' +
            getAnswerPercentageTextBox(questionId) +
            '%',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: Colors.black)));
    widgetsList.add(SizedBox(
      height: 10,
    ));
    widgetsList.add(Text('Answers:',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)));
    widgetsList.add(SizedBox(
      height: 10,
    ));
    for (int i = 0; i < db.responseList.length; i++) {
      if (db.responseList[i].questionId == questionId) {
        if (db.responseList[i].response != null && db.responseList[i].response != "") {
          widgetsList.add(questionTypeTextBox(
              context,
              db.responseList[i].response,
              getUsernameFromId(db.responseList[i].userId)));
          widgetsList.add(SizedBox(
            height: 20,
          ));
        }
      }
    }
  }
  return widgetsList;
}

Widget questionTypeTextBox(
    BuildContext context, String response, String username) {
  return Container(
      color: Colors.transparent,
      child: Container(
          decoration: new BoxDecoration(
              color: Colors.blueGrey[300],
              borderRadius: new BorderRadius.only(
                  bottomLeft: const Radius.circular(10.0),
                  bottomRight: const Radius.circular(10.0),
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0))),
          child: Column(children: <Widget>[
            Text(username + " says: ",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            Text(response,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, color: Colors.black))
          ])));
}


// Create a corresponding State class.
// This class holds data related to the form.
class QuestionStatisticsState extends State<QuestionStatisticsPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return DefaultTabController(
        // Added
        length: 1, // Added
        initialIndex: 0, //Added
        child: Scaffold(
          body: buildQuestionStatisticPage(context, _scrollViewController,
              widget.questionId, widget.talkName, widget.questionIndex),
          drawer: sideDrawer(context), // Passed BuildContext in function.
        ));
  }
}

NestedScrollView buildQuestionStatisticPage(
    BuildContext context,
    ScrollController _scrollViewController,
    int questionId,
    String talkName,
    int questionIndex) {
  return new NestedScrollView(
      controller: _scrollViewController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          new SliverAppBar(
            title: new Text("Question " + questionIndex.toString()),
            pinned: true,
            floating: true,
            snap: true,
            forceElevated: innerBoxIsScrolled,
          ),
        ];
      },
      body: new Scaffold(
          body: Container(
              margin: const EdgeInsets.all(20.0),
              //color: Colors.amber[600],
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(6),
                  child: new Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          listQuestionStatistics(context, questionId))))));
}
