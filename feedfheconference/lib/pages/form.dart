import 'package:flutter/material.dart';

// Create a Form widget.
class FormPage extends StatefulWidget {
  final String title = 'Form Page';

  @override
  FormPageState createState() {
    return FormPageState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class FormPageState extends State<FormPage> with SingleTickerProviderStateMixin {
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
          body: buildFormPage(
              context, _tabController, _scrollViewController, widget.title),
          drawer: sideDrawer(context), // Passed BuildContext in function.
        ));
  }
}

NestedScrollView buildFormPage(BuildContext context, TabController _tabController,
    ScrollController _scrollViewController, String title) {
  final _formKey = GlobalKey<FormState>();
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
          child: ListView(
            children: List.generate(10, (index) {
              return Row (
                children: <Widget>[
                  Expanded(child: Column(
                      children: <Widget> [
                        Text('Question $index', style: TextStyle(fontSize: 22),),
                        Container(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            )
                        )
                      ]
                  )
                  )
                ],
              );
            },
            ),
          )
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
              )
          ),
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
