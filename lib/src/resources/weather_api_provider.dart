import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:weather_app/src/models/weather_model.dart';

class WeatherApiProvider {
  Client client = Client();
  final _apiKey = 'd2c5cdb524904fd4ab5234421191901';

  List<String> _locations = ['Adelaide', 'Brisbane', 'Bogota'];

  Future<WeatherModel> fetchWeather() async {
    final response = await client.get(
        "http://api.apixu.com/v1/forecast.json?key=$_apiKey&q=Adelaide&days=7");
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
