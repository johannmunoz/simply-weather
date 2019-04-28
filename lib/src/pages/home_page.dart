import 'package:flutter/material.dart';
import 'package:weather_app/src/blocs/weather_bloc.dart';
import 'package:weather_app/src/models/weather_model.dart';
import 'package:weather_app/src/widgets/weather_view.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;

  @override
  void initState() {
    super.initState();
    bloc.fetchWeatherList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: StreamBuilder(
          stream: bloc.getListWeather,
          builder: (context, AsyncSnapshot<List<WeatherModel>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  height: 50.0,
                  width: 50.0,
                ),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (snapshot.data.isEmpty) {
              return Container(
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text('Please add a location'),
                      SizedBox(
                        height: 10.0,
                      ),
                      FlatButton.icon(
                        color: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        icon: Icon(Icons.add),
                        label: Text('Add Location'),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/add-location'),
                      )
                    ],
                  ),
                ),
              );
            }
            bloc.enableUpdate();
            return PageView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                page = index;
                return WeatherView(
                  weatherInfo: snapshot.data[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}
