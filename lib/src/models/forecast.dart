import 'package:weather_app/src/models/forecastday.dart';

class Forecast {
  final List<Forecastday> forecastdays;

  Forecast({this.forecastdays});

  factory Forecast.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['forecastday'] as List;
    List<Forecastday> forecastdayList =
        list.map((i) => Forecastday.fromJson(i)).toList();

    return Forecast(forecastdays: forecastdayList);
  }
}
