import 'package:flutter/material.dart';
import 'package:weather_app/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            body1: TextStyle(
              color: Colors.white70,
            ),
            body2: TextStyle(
              color: Colors.white70,
            ),
            display3: TextStyle(
              color: Colors.white70,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.white)),
      home: HomePage(),
    );
  }
}
