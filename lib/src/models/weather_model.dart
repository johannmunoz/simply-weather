import 'package:weather_app/src/models/current.dart';
import 'package:weather_app/src/models/forecast.dart';
import 'package:weather_app/src/models/location.dart';

class WeatherModel {
  final Location location;
  final Current current;
  final Forecast forecast;

  WeatherModel({this.location, this.current, this.forecast});

  factory WeatherModel.fromJson(Map<String, dynamic> parsedJson) {
    return WeatherModel(
      location: Location.fromJson(parsedJson['location']),
      current: Current.fromJson(parsedJson['current']),
      forecast: Forecast.fromJson(parsedJson['forecast']),
    );
  }
}
