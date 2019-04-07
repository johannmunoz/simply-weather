import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:weather_app/src/models/weather_model.dart';
import 'package:weather_app/src/resources/assets_library.dart';
import 'package:weather_app/src/widgets/forecast_widget.dart';
import 'package:weather_app/src/widgets/my_vertical_divider.dart';
import 'package:weather_app/src/widgets/weather_widget.dart';

class WeatherView extends StatelessWidget {
  final WeatherModel weatherInfo;
  WeatherView(this.weatherInfo);

  @override
  Widget build(BuildContext context) {
    final Color color = weatherInfo.current.isDay == 0
        ? Theme.of(context).primaryColorDark
        : Theme.of(context).primaryColor;
    return Container(
      color: color,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: buildCurrentInfo(context),
          ),
          Expanded(
            child: Container(),
          ),
          buildForecastItems(),
          Expanded(
            child: Container(),
          ),
          buildInfoWeather(),
        ],
      ),
    );
  }

  Column buildCurrentInfo(BuildContext context) {
    return Column(
      children: <Widget>[
        buildIconAnimation(),
        buildLocationDate(context),
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            buildCurrentTemperature(context),
            buildMinMax(context),
          ],
        ),
      ],
    );
  }

  Widget buildIconAnimation() {
    final int code = weatherInfo.current.condition.code;
    final int isDay = weatherInfo.current.isDay;
    print("${weatherInfo.location.name}: $code - $isDay");
    final String path = assetsLibrary.getAnimation(code, isDay);
    print(path);
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Container(
        height: 128.0,
        width: 128.0,
        child: FlareActor(
          path,
          animation: "go",
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Container buildCurrentTemperature(BuildContext context) {
    return Container(
      child: Text(
        weatherInfo.current.temperature.round().toString(),
        style: Theme.of(context).textTheme.display4,
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
          ),
          ForecastWidget(
            title: 'Rain',
            icon: Icons.invert_colors,
            value: weatherInfo.current.precipitation.toString() + ' mm',
          ),
          MyVerticalDivider(
            height: 70.0,
            width: 2.0,
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
      height: 90.0,
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

  Row buildMinMax(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.arrow_upward,
        ),
        Text(
          '${weatherInfo.forecast.forecastdays[0].day.maxtemp.round()}°',
          style: Theme.of(context).textTheme.body1,
        ),
        SizedBox(
          width: 8.0,
        ),
        Icon(
          Icons.arrow_downward,
        ),
        Text(
          '${weatherInfo.forecast.forecastdays[0].day.mintemp.round()}°',
          style: Theme.of(context).textTheme.body1,
        ),
      ],
    );
  }

  Container buildLocationDate(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            '${weatherInfo.location.name}, ${weatherInfo.location.country}',
            style: Theme.of(context).textTheme.body2,
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            weatherInfo.location.localtime,
            style: Theme.of(context).textTheme.body1,
          ),
        ],
      ),
    );
  }
}
