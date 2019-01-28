import 'package:intl/intl.dart';
import 'package:weather_app/src/models/current.dart';

class Forecastday {
  final String date;
  final Day day;
  final Astro astro;

  Forecastday({this.date, this.day, this.astro});

  factory Forecastday.fromJson(Map<String, dynamic> parsedJson) {
    final f = DateFormat('MMM d');
    return Forecastday(
      date: f.format(DateTime.parse(parsedJson['date'])),
      day: Day.fromJson(parsedJson['day']),
      astro: Astro.fromJson(parsedJson['astro']),
    );
  }
}

class Day {
  final double maxtemp;
  final double mintemp;
  final double avgtemp;
  final double precipitation;
  final double humidity;
  final Condition condition;
  final double uv;

  Day({
    this.maxtemp,
    this.mintemp,
    this.avgtemp,
    this.precipitation,
    this.humidity,
    this.condition,
    this.uv,
  });

  factory Day.fromJson(Map<String, dynamic> parsedJson) {
    return Day(
      maxtemp: parsedJson['maxtemp_c'],
      mintemp: parsedJson['mintemp_c'],
      avgtemp: parsedJson['avgtemp_c'],
      precipitation: parsedJson['totalprecip_mm'],
      humidity: parsedJson['avghumidity'],
      condition: Condition.fromJson(parsedJson['condition']),
      uv: parsedJson['uv'],
    );
  }
}

class Astro {
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;

  Astro({this.sunrise, this.sunset, this.moonrise, this.moonset});

  factory Astro.fromJson(Map<String, dynamic> parsedJson) {
    return Astro(
      sunrise: parsedJson['sunrise'],
      sunset: parsedJson['sunset'],
      moonrise: parsedJson['moonrise'],
      moonset: parsedJson['moonset'],
    );
  }
}
