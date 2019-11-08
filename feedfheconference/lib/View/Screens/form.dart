import 'package:flutter/material.dart';
import '../../Model/db.dart';
// Create a Form widget.

class FormPage extends StatefulWidget {
  final String title = 'Form Page';

  @override
  FormPageState createState() {
    return FormPageState();
  }
}

List<Widget> listMyWidgets(var formKey, var context){
  var db = Database();
  @override
  List<Widget> widgetsList = new List();

    for (int i = 0; i < db.questions.length; i++) {
      widgetsList.add(QuestionText(db.questions[i].questionText));
      widgetsList.add(AnswerBox());
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

class AnswerBox extends StatelessWidget {
  TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextFormField(
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
          onChanged: (text) {
            _controller.text = text;
            // isto nao faz com que o valor continue la
            // nao sei o que tenho de mudar para que isso aconteca
          },
        ),
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
            child: ListView(
              padding: const EdgeInsets.all(6),
              children: listMyWidgets(_formKey, context)
                
              
            )),
      ),
    ),
  );
}

Drawer sideDrawer(BuildContext context) {
  return new Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the drawer if there isn't enough vertical
    // space to fit everything.
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.12,
          child: DrawerHeader(
              child: Text('Menu', style: TextStyle(color: Colors.white)),
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Color.fromRGBO(3, 44, 115, 1),
              )),
        ),
        ListTile(
          title: Text('Home Page'),
          onTap: () {
            Navigator.of(context).pushNamed("/home");
            //Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Form'),
          onTap: () {
            Navigator.of(context).pushNamed("/form");
            //Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Favorites'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
