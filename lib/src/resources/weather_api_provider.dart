import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:weather_app/src/models/search_model.dart';
import 'dart:convert';

import 'package:weather_app/src/models/weather_model.dart';

class WeatherApiProvider {
  Client client = Client();

  String apiKey = '4c65e15aa49552f68a063b06cf9b1b2a';

  final _fetchLocationsEndpoint = 'http://api.openweathermap.org/data/2.5/find';
  final _fetchWeatherEndpoint =
      'http://api.openweathermap.org/data/2.5/onecall';

  Future<WeatherModel> fetchWeather(double lat, double long) async {
    try {
      final response = await client.get(
          "$_fetchWeatherEndpoint?lat=$lat&lon=$long&exclude=minutely,hourly&appid=$apiKey");
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        return WeatherModel.fromJson(json.decode(response.body));
      } else {
        // If that call was not successful, throw an error.
        print(response.body);
        throw Exception('Failed to load post');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load post');
    }
  }

  Future<SearchModel> fetchLocations(String query) async {
    try {
      final response =
          await client.get("$_fetchLocationsEndpoint?q=$query&appid=$apiKey");

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        print(json.decode(response.body));
        return SearchModel.fromJson(response.body);
      } else {
        // If that call was not successful, throw an error.
        print(response.body);
        throw Exception('Failed to load post');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load post');
    }
  }
}
