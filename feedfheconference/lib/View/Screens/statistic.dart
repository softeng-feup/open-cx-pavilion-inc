import 'dart:ffi';

import 'package:flutter/material.dart';
import '../../Model/db.dart';
import './questionStatistic.dart';

class StatisticsForm extends StatefulWidget {
  final String talkName;
  final int formId;

  @override
  StatisticsForm(  { Key key, this.formId, this.talkName}) : super(key: key);
  _StatisticsFormState createState() => _StatisticsFormState();
}

class _StatisticsFormState extends State<StatisticsForm> {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: buildStatisticsForm(context, _tabController, _scrollViewController, widget.formId, widget.talkName),
      ),
    );
  }
}

List<Widget> listMyQuestions(var formId, String talkName) {
  @override
  List<Widget> listQuestion = new List();

  int index = 0;

  for(int i = 0; i < db.formList.length; i++){
    if(db.formList[i].id == formId){
      FormTalk form = db.formList[i];
      for(int h = 0; h < form.listIdFormQuestions.length; h++){
        for(int j = 0; j < db.formQuestionList.length; j++){
          if(form.listIdFormQuestions[h] == db.formQuestionList[j].id){
            index++;
            listQuestion.add(QuestionText(db.formQuestionList[j].questionText, j, talkName, index));
            break;
          }
        }
      }
      break;
    }
  }
  return listQuestion;
}

class QuestionText extends StatelessWidget {
  final String questionText;
  final int questionId;
  final String talkName;
  final int index;
  QuestionText(this.questionText, this.questionId, this.talkName, this.index);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                questionText,
                style: TextStyle(fontSize: 22),
              )
            ],
          ),
          margin: const EdgeInsets.only(bottom: 8.0)
        //color: Colors.blue[100],
      ),
      onTap: () {
        var route = MaterialPageRoute(
          builder: (BuildContext context) => new QuestionStatisticsPage(talkName: this.talkName, questionIndex: this.index, questionId: questionId)
        );
        Navigator.of(context).push(route);
      },
    );
  }
}

NestedScrollView buildStatisticsForm(
    BuildContext context,
    TabController _tabController,
    ScrollController _scrollViewController,
    int formId,
    String talkName) {
  return new NestedScrollView(
    controller: _scrollViewController,
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        new SliverAppBar(
          title: new Text(talkName + '\nQuestions'),
        )
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
                  children: listMyQuestions(formId, talkName)
              )
          )
      ),
    ),
  );
}
