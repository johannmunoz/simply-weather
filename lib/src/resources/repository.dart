import 'dart:async';

import 'package:weather_app/src/models/search_model.dart';
import 'package:weather_app/src/models/weather_model.dart';
import 'package:weather_app/src/resources/weather_api_provider.dart';

class Repository {
  final weatherApiProvider = WeatherApiProvider();

  Future<WeatherModel> fetchWeather(String location) => weatherApiProvider.fetchWeather(location);
  Future<SearchModel> fetchLocations(String query) => weatherApiProvider.fetchLocations(query);
}
