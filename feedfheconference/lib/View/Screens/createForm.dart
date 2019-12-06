import 'package:flutter/cupertino.dart';
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
            for (int k = 0; k < db.formQuestionList[j].questionSubText.length; k++){
              widgetsList.add(QuestionSubText(db.formQuestionList[j].questionSubText[k], k+1));
            }
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

class QuestionSubText extends StatelessWidget {
  final String questionSubText;
  final int index;

  QuestionSubText(this.questionSubText, this.index);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
          index.toString() + ". " + questionSubText,
          style: TextStyle(fontSize: 18),
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
  final _questionKey = GlobalKey<FormState>();
  final _optionKey = GlobalKey<FormState>();
  bool _saveOptionVisible = false;
  bool _addOptionVisible = false;
  bool _saveQuestionVisible = false;
  bool _saveFormVisible = true;
  String optionText;
  List questionSubText = new List();
  QuestionType questionType = QuestionType.textBox;
  String questionText;
  String dropdownValue = 'Text';
  int formId;

  _AddQuestionTextState(this.formId);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _questionKey,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(questionSubText.length, (i) {
                return Container(
                    child: Text(
                        (i+1).toString() + ". " + questionSubText[i],
                      style: TextStyle(fontSize: 18),
                    ),
                    margin: const EdgeInsets.only(bottom: 8.0)
                  //color: Colors.blue[100],
                );
              }),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Form(
                    key: _optionKey,
                    child: Column(
                      children: <Widget>[
                        Visibility(
                          visible: _saveOptionVisible,
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onChanged: (value) => optionText = value,
                            minLines: 1,
                            maxLines: 4,
                            decoration: new InputDecoration(
                              labelText: "Your option",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(),
                              ),
                              //fillColor: Colors.green
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _saveOptionVisible,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () {
                                    if (_optionKey.currentState.validate()) {
                                      questionSubText.add(optionText);

                                      setState(() {
                                        _saveOptionVisible = false;
                                        _addOptionVisible = true;
                                        _saveQuestionVisible = true;
                                      });

          //                      Navigator.pushAndRemoveUntil(
          //                          context,
          //                          MaterialPageRoute(
          //                              builder: (context) =>
          //                                  CreateFormPage(formId: formId)),
          //                              (Route<dynamic> route) =>
          //                          false);
                                    }
                                  },
                                  child: Text('Save option')
                              ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _saveOptionVisible = false;
                                _addOptionVisible = true;
                              });
                            }, icon: Icon(Icons.delete))
                              ]
                          )
                        ),
                        Visibility(
                            visible: _addOptionVisible,
                            child: RaisedButton(
                              onPressed: () {
                                // Validate returns true if the form is valid, or false
                                // otherwise.
                                setState(() {
                                  _saveOptionVisible = true;
                                  _addOptionVisible = false;
                                  //_saveQuestionVisible = false;
                                });
                              },
                              child: Text('Add option'),
                            )
                        )
                      ]
                    )
                  )
            ),
            Visibility(
              visible: _saveQuestionVisible,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                      onPressed: () {
                        FormQuestion question = new FormQuestion(db.formQuestionList.length+1, questionType, questionText, questionSubText);
                        db.formQuestionList.add(question);
                        if (_questionKey.currentState.validate()) {
                          for(int i = 0; i < db.formList.length; i++){
                            if(db.formList[i].id == formId){
                              db.formList[i].listIdFormQuestions.add(question.id);
                              break;
                            }
                          }

                          setState(() {
                            _saveQuestionVisible = false;
                            _saveFormVisible = true;
                          });

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CreateFormPage(formId: formId)));
                        }
                      },
                      child: Text('Save question')
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;

                        if (newValue == 'Checkbox') {
                          questionType = QuestionType.checkBox;
                          _addOptionVisible = true;
                        } else if (newValue == 'Radio Button') {
                          questionType = QuestionType.radioButton;
                          _addOptionVisible = true;
                        } else {
                          questionType = QuestionType.textBox;
                          _addOptionVisible = false;
                          _saveOptionVisible = false;
                        }
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
                          dropdownValue = 'Text';
                          _saveOptionVisible = false;
                          _addOptionVisible = false;
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: listMyWidgets( formId,context)
                )
            )),
      ),
  );
}
