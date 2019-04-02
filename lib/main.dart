import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/src/pages/add_location_page.dart';
import 'package:weather_app/src/pages/home_page.dart';
import 'package:weather_app/src/pages/manage_locations_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Weather',
      theme: ThemeData(
        primaryColor: Colors.blue[700],
        accentColor: Colors.blue[100],
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
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        hintColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          prefixStyle: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/manage-locations': (context) => ManageLocationsPage(),
        '/add-location': (context) => AddLocationPage(),
      },
    );
  }
}
