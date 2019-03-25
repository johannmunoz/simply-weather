import 'package:flutter/material.dart';
import 'package:weather_app/src/models/weather_model.dart';
import 'package:weather_app/src/widgets/forecast_widget.dart';
import 'package:weather_app/src/widgets/my_vertical_divider.dart';
import 'package:weather_app/src/widgets/weather_widget.dart';

class WeatherView extends StatelessWidget {
  final WeatherModel weatherInfo;
  WeatherView(this.weatherInfo);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              
            },
            child: buildCurrentInfo(),
          ),
          Expanded(
            child: Container(),
          ),
          buildForecastItems(),
          Expanded(
            child: Container(),
          ),
          buildInfoWeather(),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  Column buildCurrentInfo() {
    return Column(
      children: <Widget>[
        Image.network(
          weatherInfo.current.condition.icon,
          scale: 0.5,
        ),
        buildLocationDate(),
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            buildCurrentTemperature(),
            buildMinMax(),
          ],
        ),
      ],
    );
  }

  Container buildCurrentTemperature() {
    return Container(
      child: Text(
        weatherInfo.current.temperature.round().toString(),
        style: TextStyle(
          fontSize: 150.0,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Padding buildInfoWeather() {
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
            value: weatherInfo.current.humidity.toString() + ' %',
          ),
          MyVerticalDivider(
            height: 70.0,
            width: 2.0,
            color: Colors.white70,
          ),
          ForecastWidget(
            title: 'Rain',
            icon: Icons.invert_colors,
            value: weatherInfo.current.precipitation.toString() + ' mm',
          ),
          MyVerticalDivider(
            height: 70.0,
            width: 2.0,
            color: Colors.white70,
          ),
          ForecastWidget(
            title: 'UV',
            icon: Icons.wb_sunny,
            value: weatherInfo.current.uv.toString(),
          ),
        ],
      ),
    );
  }

  Container buildForecastItems() {
    return Container(
      height: 80.0,
      padding: EdgeInsets.only(left: 15.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherInfo.forecast.forecastdays.length - 1,
        itemBuilder: (context, index) {
          return WeatherWidget(
            forecastday: weatherInfo.forecast.forecastdays[index + 1],
          );
        },
      ),
    );
  }

  Row buildMinMax() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.arrow_upward,
          color: Colors.white70,
        ),
        Text(
          '${weatherInfo.forecast.forecastdays[0].day.maxtemp.round()}°',
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
          '${weatherInfo.forecast.forecastdays[0].day.mintemp.round()}°',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Container buildLocationDate() {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            '${weatherInfo.location.name}, ${weatherInfo.location.country}',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            weatherInfo.location.localtime,
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
