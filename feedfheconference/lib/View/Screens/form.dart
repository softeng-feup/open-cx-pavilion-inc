import 'package:flutter/material.dart';
import '../../Model/db.dart';
import './common.dart';
// Create a Form widget.

class FormPage extends StatefulWidget {
  final String title = 'Form Page';

  @override
  FormPageState createState() {
    return FormPageState();
  }
}

List<Widget> listMyWidgets(var formKey, var context){
  @override
  List<Widget> widgetsList = new List();


  for (int i = 0; i < db.formList[0].listIdFormQuestions.length; i++) {
    for(int j = 0; j < db.formQuestionList.length; j++) {
      if(db.formQuestionList[j].id == db.formList[0].listIdFormQuestions[i]) {
        widgetsList.add(QuestionText(
            db.formQuestionList[j]
                .questionText));
        widgetsList.add(AnswerBox(db.formQuestionList[j].type, db.formQuestionList[j].questionSubText));
      }
    }
  }

  widgetsList.add(Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: RaisedButton(
      onPressed: () {
        // Validate returns true if the form is valid, or false
        // otherwise.
        if (formKey.currentState.validate()) {
          Navigator.pop(context);
        }
      },
      child: Text('Submit'),
    ),
  ));

  return widgetsList;
}


class QuestionText extends StatelessWidget {
  final String questionText;
  QuestionText(this.questionText);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
          questionText,
          style: TextStyle(fontSize: 22),
        ),
        margin: const EdgeInsets.only(bottom: 8.0)
      //color: Colors.blue[100],
    );
  }
}

class AnswerBox extends StatefulWidget {
  QuestionType type;
  List questionSubText;

  AnswerBox(this.type, this.questionSubText);

  @override
  State<StatefulWidget> createState() => _AnswerBoxState(this.type, this.questionSubText);
}

class _AnswerBoxState extends State<AnswerBox> {
  QuestionType type;
  List questionSubText;
  int _radioValue = -1;
  List _checkBoxValues = new List();

  _AnswerBoxState(this.type, this.questionSubText);

  Widget answerBox(QuestionType type, List questionSubText) {
    if (type == QuestionType.textBox) {
      return TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        minLines: 1,
        maxLines: 4,
        decoration: new InputDecoration(
          labelText: "Your answer",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(),
          ),
          //fillColor: Colors.green
        ),
      );
    } else if (type == QuestionType.radioButton) {
      return Column(
            children: List.generate(questionSubText.length, (index) {
              return ListTile(
                title: Text(questionSubText[index]),
                leading: Radio(
                    value: index,
                    groupValue: _radioValue,
                    onChanged: (int e) => setState(() {_radioValue = e;}))
              );
            }),
          );
    } else if (type == QuestionType.checkBox) {
      return Column(
        children: List.generate(questionSubText.length, (index) {
          _checkBoxValues.add(false);

          return ListTile(
              title: Text(questionSubText[index]),
              leading: Checkbox(
                  value: _checkBoxValues[index],
                  onChanged: (bool e) => setState(() {_checkBoxValues[index] = e;}))
          );
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        child: answerBox(this.type, this.questionSubText),
        margin: const EdgeInsets.only(bottom: 18.0)
      //color: Colors.blue[200],
    );
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class FormPageState extends State<FormPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return DefaultTabController(
      // Added
        length: 1, // Added
        initialIndex: 0, //Added
        child: Scaffold(
          body: buildFormPage(context, _tabController, _scrollViewController,
              _formKey, widget.title),
          drawer: sideDrawer(context), // Passed BuildContext in function.
        ));
  }
}

NestedScrollView buildFormPage(
    BuildContext context,
    TabController _tabController,
    ScrollController _scrollViewController,
    GlobalKey<FormState> _formKey,
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
    body: new Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
            margin: const EdgeInsets.all(20.0),
            //color: Colors.amber[600],
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(6),
                child: new Column(
                    children: listMyWidgets(_formKey, context)
                )


            )),
      ),
    ),
  );
}
