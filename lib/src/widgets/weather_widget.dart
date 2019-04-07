import 'package:flutter/material.dart';
import 'package:weather_app/src/models/forecastday.dart';
import 'package:weather_app/src/resources/assets_library.dart';
import 'package:weather_app/src/widgets/my_vertical_divider.dart';

class WeatherWidget extends StatelessWidget {
  final Forecastday forecastday;
  const WeatherWidget({
    Key key,
    this.forecastday,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int code = forecastday.day.condition.code;
    final String path = assetsLibrary.getIcon(code);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.0),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                forecastday.date,
                style: Theme.of(context).textTheme.subtitle,
              ),
              SizedBox(
                height: 6.0,
              ),
              Image.asset(
                path,
                scale: 1.2,
              ),
              Expanded(
                child: Container(),
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.arrow_upward,
                    size: 16.0,
                  ),
                  Text(
                    forecastday.day.maxtemp.round().toString() + '°',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                  Icon(
                    Icons.arrow_downward,
                    size: 16.0,
                  ),
                  Text(
                    forecastday.day.mintemp.round().toString() + '°',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ],
              ),
            ],
          ),
          MyVerticalDivider(
            height: 90,
            color: Colors.white70,
            margin: 10.0,
          ),
        ],
      ),
    );
  }
}
