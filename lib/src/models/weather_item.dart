import 'dart:convert';

import 'package:intl/intl.dart';

import 'package:weather_app/src/models/search_model.dart';
import 'package:weather_app/src/models/weather_model.dart';

class WeatherItem {
  int id;
  String location;
  String country;
  CurrentItem current;
  List<ForecastItem> forecast;
  WeatherItem({
    this.id,
    this.location,
    this.country,
    this.current,
    this.forecast,
  });
  factory WeatherItem.fromModel(WeatherModel weather, SearchInfo search) {
    return WeatherItem(
      id: search.id,
      location: search.name,
      country: search.sys.country,
      current: CurrentItem(
        date: _getFormatedDate(weather.current.dt, 'long'),
        isDay: _getIsDay(weather.current),
        temp: _getCelciusTemp(weather.current.temp, true),
        feelsLikeTemp: _getCelciusTemp(weather.current.feelsLike),
        humidity: '${weather.current.humidity.round()} %',
        pressure: '${weather.current.pressure} hPa',
        uv: '${weather.current.uvi.round()}',
        windSpeed: '${weather.current.windSpeed} m/s',
        iconCode: weather.current.weather.first.icon,
      ),
      forecast: weather.daily
          .map(
            (e) => ForecastItem(
              date: _getFormatedDate(e.dt),
              minTemp: _getCelciusTemp(e.temp.min),
              maxTemp: _getCelciusTemp(e.temp.max),
              humidity: '${e.humidity.round()} %',
              pressure: '${e.pressure} hPa',
              uv: '${e.uvi.round()}',
              windSpeed: '${e.windSpeed} m/s',
              rain: '${e.rain.round()} mm/h',
              iconCode: e.weather.first.icon,
            ),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'location': location,
      'country': country,
      'current': current?.toMap(),
      'forecast': forecast?.map((x) => x?.toMap())?.toList(),
    };
  }

  static WeatherItem fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return WeatherItem(
      id: map['id'],
      location: map['location'],
      country: map['country'],
      current: CurrentItem.fromMap(map['current']),
      forecast: List<ForecastItem>.from(
          map['forecast']?.map((x) => ForecastItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static WeatherItem fromJson(String source) => fromMap(json.decode(source));
}

class CurrentItem {
  String date;
  bool isDay;
  String temp;
  String feelsLikeTemp;
  String pressure;
  String humidity;
  String uv;
  String windSpeed;
  String windDeg;
  String iconCode;
  CurrentItem({
    this.date,
    this.isDay,
    this.temp,
    this.feelsLikeTemp,
    this.pressure,
    this.humidity,
    this.uv,
    this.windSpeed,
    this.windDeg,
    this.iconCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'isDay': isDay,
      'temp': temp,
      'feelsLikeTemp': feelsLikeTemp,
      'pressure': pressure,
      'humidity': humidity,
      'uv': uv,
      'windSpeed': windSpeed,
      'windDeg': windDeg,
      'iconCode': iconCode,
    };
  }

  static CurrentItem fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CurrentItem(
      date: map['date'],
      isDay: map['isDay'],
      temp: map['temp'],
      feelsLikeTemp: map['feelsLikeTemp'],
      pressure: map['pressure'],
      humidity: map['humidity'],
      uv: map['uv'],
      windSpeed: map['windSpeed'],
      windDeg: map['windDeg'],
      iconCode: map['iconCode'],
    );
  }

  String toJson() => json.encode(toMap());

  static CurrentItem fromJson(String source) => fromMap(json.decode(source));
}

class ForecastItem {
  String date;
  String minTemp;
  String maxTemp;
  String pressure;
  String humidity;
  String uv;
  String windSpeed;
  String windDeg;
  String clouds;
  String rain;
  String iconCode;
  ForecastItem({
    this.date,
    this.minTemp,
    this.maxTemp,
    this.pressure,
    this.humidity,
    this.uv,
    this.windSpeed,
    this.windDeg,
    this.clouds,
    this.rain,
    this.iconCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'minTemp': minTemp,
      'maxTemp': maxTemp,
      'pressure': pressure,
      'humidity': humidity,
      'uv': uv,
      'windSpeed': windSpeed,
      'windDeg': windDeg,
      'clouds': clouds,
      'rain': rain,
      'iconCode': iconCode,
    };
  }

  static ForecastItem fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ForecastItem(
      date: map['date'],
      minTemp: map['minTemp'],
      maxTemp: map['maxTemp'],
      pressure: map['pressure'],
      humidity: map['humidity'],
      uv: map['uv'],
      windSpeed: map['windSpeed'],
      windDeg: map['windDeg'],
      clouds: map['clouds'],
      rain: map['rain'],
      iconCode: map['iconCode'],
    );
  }

  String toJson() => json.encode(toMap());

  static ForecastItem fromJson(String source) => fromMap(json.decode(source));
}

bool _getIsDay(CurrentInfo weatherInfo) {
  final currentTime = weatherInfo.dt;
  final sunriseTime = weatherInfo.sunrise;
  final sunsetTime = weatherInfo.sunset;

  if (currentTime.isAfter(sunriseTime) && currentTime.isBefore(sunsetTime)) {
    return true;
  } else {
    return false;
  }
}

String _getCelciusTemp(double value, [bool hideSymbol = false]) {
  final result = value - 273.15;
  if (hideSymbol) {
    return '${result.round()}°';
  }
  return '${result.round()} °C';
}

String _getFormatedDate(DateTime dateTime, [String formatType = 'short']) {
  DateFormat format;
  switch (formatType) {
    case 'short':
      format = DateFormat('MMM d');
      break;
    case 'long':
      format = DateFormat('E, h:m a');
      break;
    default:
      format = DateFormat('MMM d');
  }
  return format.format(dateTime);
}
