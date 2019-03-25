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
      padding: EdgeInsets.symmetric(horizontal: 2.0),
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
              Row(
                children: <Widget>[
                  Icon(
                    Icons.arrow_upward,
                    color: Colors.white70,
                  ),
                  Text(
                    forecastday.day.maxtemp.round().toString() + '°',
                    style: Theme.of(context).textTheme.body2,
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                  Icon(
                    Icons.arrow_downward,
                    color: Colors.white70,
                  ),
                  Text(
                    forecastday.day.mintemp.round().toString() + '°',
                    style: Theme.of(context).textTheme.body2,
                  ),
                ],
              ),
            ],
          ),
          MyVerticalDivider(
            height: 80,
            color: Colors.white70,
            margin: 10.0,
          ),
        ],
      ),
    );
  }
}
