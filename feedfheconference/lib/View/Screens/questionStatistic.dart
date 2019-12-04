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
   QuestionStatisticsPage({Key key, this.questionIndex,  this.talkName,  this.questionId}): super(key: key);
   QuestionStatisticsState createState(){
    return  QuestionStatisticsState();
  }
}

List <String> getSubQuestionText(var questionId){

  for(int i = 0; i < db.formQuestionList.length; i++){
    if(db.formQuestionList[i].id == questionId){
      return db.formQuestionList[i].questionSubText;
    }
  }

}


String getQuestionText(var questionId){

  for(int i = 0; i < db.formQuestionList.length; i++){
    if(db.formQuestionList[i].id == questionId){
      return db.formQuestionList[i].questionText;
    }
  }
}

QuestionType getQuestionType(var questionId){
 
  for(int i = 0; i < db.formQuestionList.length; i++){
    if(db.formQuestionList[i].id == questionId){
      return db.formQuestionList[i].type;
    }
  }
}

List<Widget> listQuestionStatistics(var questionId){
  @override
  List<Widget> widgetsList = new List();

  String questionText = getQuestionText(questionId);
  QuestionType questionType = getQuestionType(questionId);

  if(questionType == QuestionType.checkBox || questionType == QuestionType.radioButton){
    List <String> questionSubText = getSubQuestionText(questionId);
    widgetsList.add(Text(questionText, style: TextStyle(fontWeight: FontWeight.bold)));

  }
  else{
      widgetsList.add(Text(questionText, style: TextStyle(fontWeight: FontWeight.bold)));
  }


  return widgetsList;
}

class QuestionText extends StatelessWidget {
  final String questionText;
  QuestionText(this.questionText);
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}


// Create a corresponding State class.
// This class holds data related to the form.
class  QuestionStatisticsState extends State <QuestionStatisticsPage>
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
          body: buildQuestionStatisticPage(_scrollViewController ,widget.questionId, widget.talkName, widget.questionIndex),
          drawer: sideDrawer(context), // Passed BuildContext in function.
        ));
  }
}



NestedScrollView buildQuestionStatisticPage(ScrollController _scrollViewController, int questionId, String talkName, int questionIndex) {
    

  return new NestedScrollView(
    controller: _scrollViewController,
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        new SliverAppBar(
          title: new Text(talkName + "form" + "question" + questionIndex.toString()),
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
                    children: listQuestionStatistics(questionId)
                )
            )
      )
    )
  );
}
