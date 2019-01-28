import 'package:flutter/material.dart';
import 'package:weather_app/src/blocs/weather_bloc.dart';
import 'package:weather_app/src/widgets/weather_view.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () => bloc.fetchWeather(),
          ),
        ],
      ),
      drawer: Drawer(),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: PageView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return WeatherView();
          },
        ),
      ),
    );
  }
}
