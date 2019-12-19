import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:feedfheconference/View/view.dart';


void main(){
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color.fromRGBO(3, 44, 115, 1), // status bar color
  ));

  runApp(MyApp());
}
