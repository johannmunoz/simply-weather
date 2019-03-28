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

    _locations = prefs.getStringList('locations') ?? ['Adelaide'];
    bloc.fetchWeatherList(_locations);
  }

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
            onPressed: () {
              bloc.fetchWeatherList(_locations);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                "Manage Locations",
                style: TextStyle(color: Colors.black),
              ),
              trailing: Icon(Icons.edit_location),
              onTap: () {
                Navigator.pushNamed(context, '/manage-locations');
              },
            ),
            ListTile(
              title: Text(
                "Add Locations",
                style: TextStyle(color: Colors.black),
              ),
              trailing: Icon(Icons.add_location),
              onTap: () {
                Navigator.pushNamed(context, '/add-location');
              },
            ),
            ListTile(
              title: Text(
                "Settings",
                style: TextStyle(color: Colors.black),
              ),
              trailing: Icon(Icons.settings),
              onTap: () {},
            ),
          ],
        ),
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
