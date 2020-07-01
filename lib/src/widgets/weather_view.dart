import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:weather_app/src/blocs/weather_bloc.dart';
import 'package:weather_app/src/models/weather_item.dart';
import 'package:weather_app/src/resources/assets_library.dart';
import 'package:weather_app/src/widgets/forecast_widget.dart';
import 'package:weather_app/src/widgets/my_vertical_divider.dart';
import 'package:weather_app/src/widgets/weather_widget.dart';

class WeatherView extends StatefulWidget {
  final WeatherItem weatherInfo;
  const WeatherView({Key key, this.weatherInfo}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WeatherViewState();
  }
}

class _WeatherViewState extends State<WeatherView>
    with TickerProviderStateMixin {
  static final Animatable<Offset> _positionTween = Tween<Offset>(
    begin: const Offset(2.0, 0.0),
    end: Offset.zero,
  ).chain(CurveTween(
    curve: Curves.fastOutSlowIn,
  ));

  bool _circularIndicator = false;

  AnimationController _controller;
  Animation<Offset> _positionOffset;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _positionOffset = _controller.drive(_positionTween);
    _controller.forward();
    _circularIndicator = bloc.updateButton;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDay = widget.weatherInfo.current.isDay;
    final Color color = isDay
        ? Theme.of(context).primaryColor
        : Theme.of(context).primaryColorDark;

    return Container(
      color: color,
      child: Column(
        children: <Widget>[
          buildTopBar(context),
          buildIconAnimation(context),
          Expanded(
            child: Container(),
          ),
          buildCurrentInfo(context),
          Expanded(
            child: Container(),
          ),
          buildForecastItems(context),
          Expanded(
            child: Container(),
          ),
          buildInfoWeather(),
        ],
      ),
    );
  }

  Row buildTopBar(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        _circularIndicator
            ? SizedBox(
                child: CircularProgressIndicator(),
                height: 20.0,
                width: 20.0,
              )
            : IconButton(
                icon: Icon(Icons.update),
                tooltip: "Update current weather",
                onPressed: bloc.updateButton ? null : _updateCurrentWeather,
              ),
        IconButton(
          icon: Icon(Icons.edit),
          tooltip: "Manage locations",
          onPressed: () => Navigator.pushNamed(context, '/manage-locations'),
        ),
      ],
    );
  }

  void _updateCurrentWeather() {
    bloc.fetchWeatherList();
    bloc.disableUpdate();
    setState(() {
      _circularIndicator = true;
    });
    Timer(Duration(seconds: 3), () {
      bloc.enableUpdate();
      setState(() {
        _circularIndicator = false;
      });
    });
  }

  Column buildCurrentInfo(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            buildLocationDate(context),
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                buildCurrentTemperature(context),
                buildMinMax(context),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildIconAnimation(BuildContext context) {
    final double screenSize = MediaQuery.of(context).devicePixelRatio * 48;
    final String iconCode = widget.weatherInfo.current.iconCode;
    final String path = assetsLibrary.getAnimation(iconCode);
    return SlideTransition(
      position: _positionOffset,
      child: Container(
        height: screenSize,
        width: screenSize,
        child: FlareActor(
          path,
          animation: "go",
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget buildCurrentTemperature(BuildContext context) {
    return SlideTransition(
      position: _positionOffset,
      child: Container(
        padding: EdgeInsets.only(top: 30.0),
        child: Text(
          widget.weatherInfo.current.temp,
          style: Theme.of(context).textTheme.headline1,
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
            image: 'assets/icon/cloudy.png',
            value: widget.weatherInfo.current.humidity,
          ),
          MyVerticalDivider(
            height: 70.0,
            width: 2.0,
          ),
          ForecastWidget(
            title: 'Rain',
            image: 'assets/icon/heavy_rain.png',
            value: widget.weatherInfo.forecast.first.rain,
          ),
          MyVerticalDivider(
            height: 70.0,
            width: 2.0,
          ),
          ForecastWidget(
            title: 'UV',
            image: 'assets/icon/sunny.png',
            value: widget.weatherInfo.current.uv,
          ),
        ],
      ),
    );
  }

  Container buildForecastItems(BuildContext context) {
    final double screenSize =
        82 + 15.4 * (MediaQuery.of(context).devicePixelRatio - 2);
    return Container(
      height: screenSize,
      padding: EdgeInsets.only(left: 15.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.weatherInfo.forecast.length - 1,
        itemBuilder: (context, index) {
          return WeatherWidget(
            forecastInfo: widget.weatherInfo.forecast[index + 1],
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
          widget.weatherInfo.forecast.first.maxTemp,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(
          width: 8.0,
        ),
        Icon(
          Icons.arrow_downward,
        ),
        Text(
          widget.weatherInfo.forecast.first.minTemp,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }

  Container buildLocationDate(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            '${widget.weatherInfo.location}, ${widget.weatherInfo.country}',
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            widget.weatherInfo.current.date,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
