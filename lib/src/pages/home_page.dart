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
  List<String> _locations = ['Adelaide', 'Brisbane', 'Bogota'];
  int page = 0;

  @override
  void initState() {
    bloc.fetchWeatherList(_locations);
    super.initState();
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
              // if (bloc.isLoading) {
              //   return null;
              // } else {
              //   bloc.fetchWeather(_locations[page]);
              // }
            },
          ),
        ],
      ),
      drawer: Drawer(),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: StreamBuilder(
          stream: bloc.getListWeather,
          builder: (context, AsyncSnapshot<List<WeatherModel>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  height: 100.0,
                  width: 100.0,
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
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       elevation: 0,
  //       actions: <Widget>[
  //         IconButton(
  //           icon: Icon(
  //             Icons.refresh,
  //             color: Colors.white,
  //           ),
  //           onPressed: () {
  //             // if (bloc.isLoading) {
  //             //   return null;
  //             // } else {
  //             //   bloc.fetchWeather(_locations[page]);
  //             // }
  //           },
  //         ),
  //       ],
  //     ),
  //     drawer: Drawer(),
  //     body: Container(
  //       color: Theme.of(context).primaryColor,
  //       child: PageView.builder(
  //         itemCount: _locations.length,
  //         itemBuilder: (context, index) {
  //           page = index;
  //           return WeatherView(
  //             location: _locations[index],
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}
