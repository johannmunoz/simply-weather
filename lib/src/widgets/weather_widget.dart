import 'package:flutter/material.dart';
import 'package:weather_app/src/models/weather_item.dart';
import 'package:weather_app/src/resources/assets_library.dart';
import 'package:weather_app/src/widgets/my_vertical_divider.dart';

class WeatherWidget extends StatelessWidget {
  final ForecastItem forecastInfo;
  const WeatherWidget({
    Key key,
    this.forecastInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenSize = 3.2 / MediaQuery.of(context).devicePixelRatio;
    final String iconCode = forecastInfo.iconCode;
    final String path = assetsLibrary.getIcon(iconCode);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.0),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                forecastInfo.date,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(
                height: 6.0,
              ),
              Image.asset(
                path,
                scale: screenSize,
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
                    forecastInfo.maxTemp,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                  Icon(
                    Icons.arrow_downward,
                    size: 16.0,
                  ),
                  Text(
                    forecastInfo.minTemp,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ],
          ),
          MyVerticalDivider(
            height: 68,
            color: Colors.white70,
            margin: 10.0,
          ),
        ],
      ),
    );
  }
}
