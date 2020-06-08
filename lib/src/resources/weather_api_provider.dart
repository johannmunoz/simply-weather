import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:weather_app/src/models/search_model.dart';
import 'dart:convert';

import 'package:weather_app/src/models/weather_model.dart';

class WeatherApiProvider {
  Client client = Client();
  final _apiKey = 'bebe9d4f178982a3aead9817f8281e7b';

  Future<WeatherModel> fetchWeather(String location) async {
    try {
      final response = await client.get(
          "http://api.weatherstack.com/forecast.json?access_key=$_apiKey&query=$location&days=7");
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
      final response = await client.get(
          "http://api.weatherstack.com/autocomplete?access_key=$_apiKey&query=$query");

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        return SearchModel.fromJson(json.decode(response.body));
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
