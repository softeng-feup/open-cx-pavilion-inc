import 'package:feedfheconference/Controller/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class TalkRating extends StatefulWidget {
  final int talkId;

  @override
  TalkRating({Key key, this.talkId}): super(key: key);
  _TalkRatingState createState() => _TalkRatingState();
}

class _TalkRatingState extends State<TalkRating> {
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget> [
              new SliverAppBar(
                title: Text("Rating"),
                pinned: true,
                floating: true,
                snap: true,
                forceElevated: innerBoxIsScrolled,
              )
            ];
          },
          body: new ListView(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 30)),
              Text("Give your rating to the talk", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              SizedBox(height: 20),
              Center(
                  child: SmoothStarRating(
                      onRatingChanged: (v) {
                        setState(() {
                          rating = v;
                        });
                        },
                      allowHalfRating: false,
                      starCount: 5,
                      rating: rating,
                      size: 40.0,
                      color: Colors.blue,
                      borderColor: Colors.blue,
                      spacing:0.0
                  )
              ),
              SizedBox(height: 25),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () {
                          controller.addRate(rating, widget.talkId);
                          Navigator.of(context).pop();
                        },
                      child: Text('Rate!', style: TextStyle(fontWeight: FontWeight.bold)))
              )
            ],
          )
      )
    );
  }
}
