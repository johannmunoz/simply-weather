import 'package:flutter/material.dart';
import 'package:weather_app/src/models/forecastday.dart';
import 'package:weather_app/src/widgets/my_vertical_divider.dart';

class WeatherWidget extends StatelessWidget {
  final Forecastday forecastday;
  const WeatherWidget({
    Key key,
    this.forecastday,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                forecastday.date,
                style: Theme.of(context).textTheme.body2,
              ),
              Image.network(
                forecastday.day.condition.icon,
                scale: 1.8,
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                forecastday.day.avgtemp.round().toString() + '°',
                style: Theme.of(context).textTheme.body2,
              ),
            ],
          ),
          MyVerticalDivider(
            height: 70,
            color: Colors.white70,
            margin: 14.0,
          ),
        ],
      ),
    );
  }
}
