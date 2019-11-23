import 'package:flutter/material.dart';
import '../../Model/db.dart';
import './common.dart';
// Create a Form widget.

class CreateFormPage extends StatefulWidget {
  final String title = 'Create Form Page';
  final int formId;
  CreateFormPage({Key key, this.formId}): super(key: key);
  @override
  CreateFormPageState createState() {
    return CreateFormPageState();
  }
}

List<Widget> listMyWidgets(var formId, var context){
  @override
  List<Widget> widgetsList = new List();

  for(int i = 0; i < db.formList.length; i++){
    if(db.formList[i].id == formId){
      FormTalk form = db.formList[i];
      for(int h = 0; h < form.listIdFormQuestions.length; h++){
        for(int j = 0; j < db.formQuestionList.length; j++){
          if(form.listIdFormQuestions[h] == db.formQuestionList[j].id){
            widgetsList.add(QuestionText(
              db.formQuestionList[j].questionText, h+1));
            break;
          }  
        }
      }
      break;
    }
  }

  widgetsList.add(Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: Center(
      child: Column(
        children: <Widget>[
          AddQuestionText(formId)
        ],
      )
    )
  ));

  return widgetsList;

}


class QuestionText extends StatelessWidget {
  final String questionText;
  final int index;

  QuestionText(this.questionText, this.index);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
          index.toString() + ". " + questionText,
          style: TextStyle(fontSize: 22),
        ),
        margin: const EdgeInsets.only(bottom: 8.0)
      //color: Colors.blue[100],
    );
  }
}

class AddQuestionText extends StatefulWidget {
  List<Widget> widgetsList;
  int formId;
  AddQuestionText(this.formId);

  @override
  State<StatefulWidget> createState() {
    return _AddQuestionTextState(formId);
  }
}

class _AddQuestionTextState extends State<AddQuestionText> {
  final _formKey = GlobalKey<FormState>();
  bool _saveQuestionVisible = false;
  bool _saveFormVisible = true;
  String questionText;
  String dropdownValue = 'Text';
  int formId;

  _AddQuestionTextState(this.formId);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          children: <Widget>[
            Visibility(
              visible: _saveQuestionVisible,
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (value) => questionText = value,
                minLines: 1,
                maxLines: 4,
                decoration: new InputDecoration(
                  labelText: "Your question",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
              )
            ),
            Visibility(
              visible: _saveQuestionVisible,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                      onPressed: () {
                      
                        db.formQuestionList.add(FormQuestion(db.formQuestionList.length, QuestionType.textBox, questionText, null));
                        if (_formKey.currentState.validate()) {
                          for(int i = 0; i < db.formList.length; i++){
                            if(db.formList[i].id == formId){
                              db.formList[i].listIdFormQuestions.add(db.formQuestionList.length);
                              break;
                            }
                          }
                          //widgetsList.add(QuestionText(db.questions[widgetsList.length].questionText, widgetsList.length));
                          setState(() {
                            _saveQuestionVisible = false;
                            _saveFormVisible = true;
                          });

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CreateFormPage()),
                                  (Route<dynamic> route) =>
                              false);
                        }
                      },
                      child: Text('Save')
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>['Text', 'Radio Button', 'Checkbox']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                        .toList(),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _saveQuestionVisible = false;
                          _saveFormVisible = true;
                        });
                  }, icon: Icon(Icons.delete))
                ],
              )
            ),
            Visibility(
              visible: _saveFormVisible,
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      setState(() {
                        _saveQuestionVisible = true;
                        _saveFormVisible = false;
                      });
                    },
                    child: Text('Add question'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                    },
                    child: Text('Save'),
                  )
                ],
              )
            )
      ])
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
class CreateFormPageState extends State<CreateFormPage>
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
          body: buildCreateFormPage(context, _tabController, _scrollViewController,widget.formId, widget.title),
          drawer: sideDrawer(context), // Passed BuildContext in function.
        ));
  }
}

NestedScrollView buildCreateFormPage(
    BuildContext context,
    TabController _tabController,
    ScrollController _scrollViewController, int formId,
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
      body: Container(
            margin: const EdgeInsets.all(20.0),
            //color: Colors.amber[600],
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(6),
                child: new Column(
                    children: listMyWidgets( formId,context)
                )
            )),
      ),
  );
}
