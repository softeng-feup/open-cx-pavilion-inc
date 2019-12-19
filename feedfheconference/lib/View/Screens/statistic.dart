import 'dart:math';
import 'package:flutter/cupertino.dart';
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
        for(int j = 0; j < db.formQuestionList.length; j++) {
          if(form.listIdFormQuestions[h] == db.formQuestionList[j].id){
            index++;
            listQuestion.add(QuestionText(db.formQuestionList[j].type, db.formQuestionList[j].questionText, form.listIdFormQuestions[h], talkName, index));
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
  final QuestionType type;
  final String questionText;
  final int questionId;
  final String talkName;
  final int index;
  QuestionText(this.type, this.questionText, this.questionId, this.talkName, this.index);

  @override
  Widget build(BuildContext context) {
    if(this.type == QuestionType.textBox) {
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
              ),
            ],
          ),
          margin: const EdgeInsets.only(bottom: 8.0),
          //color: Colors.blue[100],
        ),
        onTap: () {
          var route = MaterialPageRoute(
              builder: (BuildContext context) => new QuestionStatisticsPage(
                  talkName: this.talkName,
                  questionIndex: this.index,
                  questionId: questionId)
          );
          Navigator.of(context).push(route);
        },
      );
    }
    else {
      return Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                index.toString() + ". " + questionText,
                style: TextStyle(fontSize: 19),
              ),
              ExpansionTile(
                title: Text("Question statistics"),
                children: listQuestionStatistics(context, questionId),
              )
            ],
          ),
          margin: const EdgeInsets.only(bottom: 8.0),
          //color: Colors.blue[100],
        );
    }
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
                children: listMyQuestions(formId, talkName),
            )
        )
    );
  }
}

List <Widget> printQuestions(List <String> questions){

  List <Widget> listOfQuestions = new List();
  for(int i = 0; i < questions.length; i++){
    listOfQuestions.add(Text(
        questions[i],
        style: TextStyle(fontSize: 20, color: Colors.black)));
    listOfQuestions.add(SizedBox(height: 10));
  }
  return listOfQuestions;
}

class GeneralStats extends StatelessWidget {
  final int formId;

   @override
   GeneralStats(this.formId);
   Widget build(BuildContext context) {
    List <String> mostAnswered = mostAnsweredQuestions(formId);
    List <String> leastAnswered = leastAnsweredQuestions(formId);
    if(mostAnswered.length == leastAnswered.length){
      mostAnswered = ['Not enough data to display this statistic'];
      leastAnswered = ['Not enough data to display this statistic'];
    }

     return Container(
       padding: EdgeInsets.only(left: 5),
       child: Column(
         children: <Widget>[
           SizedBox(height: 40,),
           Text("Nº of people who submitted the form: " + numberOfPeopleSubmittedForm(formId).toString(), style: TextStyle(
               fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
           SizedBox(height: 20,),
           Text("Most answered questions: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
           SizedBox(height: 15),
           Column(children: printQuestions(mostAnswered), crossAxisAlignment: CrossAxisAlignment.start),
           SizedBox(height: 20),
           Text("Least answered questions: ", style: TextStyle(
               fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
           SizedBox(height: 15),
           Column(children: printQuestions(leastAnswered), crossAxisAlignment: CrossAxisAlignment.start),
           SizedBox(height: 20)
         ],
       )
     );
  }
}
