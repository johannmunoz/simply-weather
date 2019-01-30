import 'package:flutter/material.dart';
import 'package:weather_app/src/blocs/weather_bloc.dart';
import 'package:weather_app/src/models/weather_model.dart';
import 'package:weather_app/src/widgets/forecast_widget.dart';
import 'package:weather_app/src/widgets/my_vertical_divider.dart';
import 'package:weather_app/src/widgets/weather_widget.dart';

class WeatherView extends StatefulWidget {
  final String location;
  const WeatherView({
    Key key,
    this.location,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _WeatherViewState();
  }
}

class _WeatherViewState extends State<WeatherView> {
  @override
  void initState() {
    bloc.fetchWeather(widget.location);
    super.initState();
  }
  // @override
  // void dispose() {
  //   bloc.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.getWeather,
      builder: (context, AsyncSnapshot<WeatherModel> snapshot) {
        if (snapshot.hasData) {
          return buildWeatherPage(snapshot);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Column buildWeatherPage(AsyncSnapshot<WeatherModel> snapshot) {
    final data = snapshot.data;
    return Column(
      children: <Widget>[
        Image.network(
          data.current.condition.icon,
          scale: 0.5,
        ),
        buildLocationDate(data),
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            buildCurrentTemperature(data),
            buildMinMax(data),
          ],
        ),
        Expanded(
          child: Container(),
        ),
        buildForecastItems(data),
        Expanded(
          child: Container(),
        ),
        buildInfoWeather(data),
      ],
    );
  }

  Container buildCurrentTemperature(WeatherModel data) {
    return Container(
      child: Text(
        data.current.temperature.round().toString(),
        style: TextStyle(
          fontSize: 150.0,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Padding buildInfoWeather(WeatherModel data) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15.0,
        left: 5.0,
        right: 5.0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ForecastWidget(
            title: 'Humidity',
            icon: Icons.cloud_queue,
            value: data.current.humidity.toString() + ' %',
          ),
          MyVerticalDivider(
            height: 70.0,
            width: 2.0,
            color: Colors.white70,
          ),
          ForecastWidget(
            title: 'Rain',
            icon: Icons.invert_colors,
            value: data.current.precipitation.toString() + ' mm',
          ),
          MyVerticalDivider(
            height: 70.0,
            width: 2.0,
            color: Colors.white70,
          ),
          ForecastWidget(
            title: 'UV',
            icon: Icons.wb_sunny,
            value: data.current.uv.toString(),
          ),
        ],
      ),
    );
  }

  Container buildForecastItems(WeatherModel data) {
    return Container(
      height: 72.0,
      padding: EdgeInsets.only(left: 15.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.forecast.forecastdays.length - 1,
        itemBuilder: (context, index) {
          return WeatherWidget(
            forecastday: data.forecast.forecastdays[index + 1],
          );
        },
      ),
    );
  }

  Row buildMinMax(WeatherModel data) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.arrow_upward,
          color: Colors.white70,
        ),
        Text(
          '${data.forecast.forecastdays[0].day.maxtemp.round()}°',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
        SizedBox(
          width: 8.0,
        ),
        Icon(
          Icons.arrow_downward,
          color: Colors.white70,
        ),
        Text(
          '${data.forecast.forecastdays[0].day.mintemp.round()}°',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Container buildLocationDate(WeatherModel data) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            '${data.location.name}, ${data.location.country}',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            data.location.localtime,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white54,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
