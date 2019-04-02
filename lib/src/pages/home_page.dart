import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/src/blocs/weather_bloc.dart';
import 'package:weather_app/src/models/weather_model.dart';
import 'package:weather_app/src/widgets/weather_view.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _locations = [];
  int page = 0;

  @override
  void initState() {
    _getLocations();

    super.initState();
  }

  void _getLocations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _locations = prefs.getStringList('locations') ?? [];
    bloc.fetchWeatherList(_locations);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: "Manage locations",
            onPressed: () => Navigator.pushNamed(context, '/manage-locations'),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: bloc.getListWeather,
        builder: (context, AsyncSnapshot<List<WeatherModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 60.0,
                width: 60.0,
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.data.isEmpty) {
            return Container(
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Text('Please add a location'),
              ),
            );
          }
          return PageView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              page = index;
              return WeatherView(snapshot.data[index]);
            },
          );
        },
      ),
    );
  }
}
