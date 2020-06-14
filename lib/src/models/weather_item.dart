import 'package:intl/intl.dart';

import 'package:weather_app/src/models/search_model.dart';
import 'package:weather_app/src/models/weather_model.dart';

class WeatherItem {
  String location;
  String country;
  CurrentItem current;
  List<ForecastItem> forecast;
  WeatherItem({
    this.location,
    this.country,
    this.current,
    this.forecast,
  });
  factory WeatherItem.fromModel(WeatherModel weather, SearchInfo search) {
    return WeatherItem(
      location: search.name,
      country: search.sys.country,
      current: CurrentItem(
        date: _getFormatedDate(weather.current.dt),
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

String _getFormatedDate(DateTime dateTime) {
  final f = DateFormat('MMM d');
  return f.format(dateTime);
}
