import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/src/pages/about_page.dart';
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
      title: 'MyWeather',
      theme: buildThemeData(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/manage-locations': (context) => ManageLocationsPage(),
        '/add-location': (context) => AddLocationPage(),
        '/about': (context) => AboutPage(),
      },
    );
  }

  ThemeData buildThemeData() {
    return ThemeData(
      primaryColor: Colors.blue[700],
      primaryColorDark: Colors.indigo[800],
      accentColor: Colors.blue[100],
      fontFamily: 'Montserrat',
      textTheme: TextTheme(
        body1: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
        body2: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
        display4: TextStyle(
          color: Colors.white,
          fontSize: 150.0,
        ),
        subtitle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
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
    );
  }
}
