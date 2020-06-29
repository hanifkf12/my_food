import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///D:/Projek/Test%20Company/Code%20House/my_food/lib/screen/about_page.dart';
import 'package:my_food/bloc/food_bloc.dart';
import 'file:///D:/Projek/Test%20Company/Code%20House/my_food/lib/screen/detail_page.dart';
import 'package:my_food/network/api_network.dart';
import 'package:my_food/screen/home_page.dart';

import 'model/meals.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Quicksand',
          primaryColor: Color(0xff2ecc71),
          accentColor: Color(0xff1abc9c)),
      home: MyHomePage(title: 'My Food'),
    );
  }
}

