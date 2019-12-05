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

List<Response> questionResponses(int questionId) {
  @override
  List<Response> responsesList = new List();

  for (int j = 0; j < db.responseList.length; j++) {
    if(db.responseList[j].questionId == questionId) {
      responsesList.add(db.responseList[j]);
    }
  }
  return responsesList;
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
            listQuestion.add(QuestionText(db.formQuestionList[j].questionText, form.listIdFormQuestions[h], talkName, index));
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
          color: Colors.grey[200],
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                index.toString() + ". " + questionText,
                style: TextStyle(fontSize: 19),
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
          title: new Text('Form statistics'),
          bottom: new TabBar(tabs: [Tab(text: "Questions"), Tab(text: "General stats")],
          controller: _tabController),
        )
      ];
    },
    body: new TabBarView(
      children: <Widget>[
        QuestionsListPage(formId, talkName),
        GeneralStats(formId)
      ],
    )
  );
}

class QuestionsListPage extends StatelessWidget {
  final int formId;
  final String talkName;

  @override
  QuestionsListPage(this.formId, this.talkName);
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.all(20.0),
        //color: Colors.amber[600],
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(6),
            child: new Column(
                children: listMyQuestions(formId, talkName)
            )
        )
    );
  }
}

class GeneralStats extends StatelessWidget {
  final int formId;

   @override
   GeneralStats(this.formId);
   Widget build(BuildContext context) {
     List<List<Response>> responses = new List();
     FormTalk form;

     for(int i = 0; i < db.formList.length; i++) {
       if(formId == db.formList[i].id) {
         form = db.formList[i];
         for(int j = 0; j < form.listIdFormQuestions.length; j++) {
           responses.add(questionResponses(form.listIdFormQuestions[j]));
         }
       }
     }

     FormQuestion lessRespondedQuestion;
     int lessRespondedQuestionId;

     for(int i = 0; i < responses.length; i++) {
       if(i == 0)
         lessRespondedQuestionId = form.listIdFormQuestions[i];

       else if(responses[i].length < responses[lessRespondedQuestionId].length)
         lessRespondedQuestionId = form.listIdFormQuestions[i];

     }

     for(int i = 0; i < db.formQuestionList.length; i++) {
       if(db.formQuestionList[i].id == lessRespondedQuestionId)
         lessRespondedQuestion = db.formQuestionList[i];
     }

    return new Text(lessRespondedQuestion.questionText);
  }
}

