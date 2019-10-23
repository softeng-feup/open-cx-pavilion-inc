import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'FeedTheConference';

    return MaterialApp(
      title: title,
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // Added
        length: 2, // Added
        initialIndex: 0, //Added
        child: Scaffold(
          body: HomePage(
              context, _tabController, _scrollViewController, widget.title),
          drawer: sideDrawer(context), // Passed BuildContext in function.
        ));
  }
}

NestedScrollView HomePage(BuildContext context, TabController _tabController,
    ScrollController _scrollViewController, String title) {
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
          bottom: new TabBar(
            tabs: <Tab>[
              new Tab(text: "Test 1"),
              new Tab(text: "Test 2"),
            ],
            controller: _tabController,
          ),
        ),
      ];
    },
    body: new TabBarView(
      children: <Widget>[
        new CurrentPage(),
        new CurrentPage(),
      ],
      controller: _tabController,
    ),
  );
}

class CurrentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new GridView.count(
      crossAxisCount: 1,
      children: List.generate(100, (index) {
        return Center(
          child: Text(
            'Session $index',
            style: Theme.of(context).textTheme.headline,
          ),
        );
      }),
    );
  }
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
              child: Text('Menu'),
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Colors.blue,
              )
          ),
        ),
        ListTile(
          title: Text('Home Page'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Form'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
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
