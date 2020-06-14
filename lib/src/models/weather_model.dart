import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherModel {
  @JsonKey(fromJson: _numberToDouble)
  final double lat;
  @JsonKey(fromJson: _numberToDouble)
  final double lon;
  final CurrentInfo current;
  final List<ForecastInfo> daily;

  WeatherModel({this.lat, this.lon, this.current, this.daily});

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ForecastInfo {
  @JsonKey(fromJson: _numberToDate)
  DateTime dt;
  @JsonKey(fromJson: _numberToDate)
  DateTime sunrise;
  @JsonKey(fromJson: _numberToDate)
  DateTime sunset;
  Temperature temp;
  @JsonKey(name: 'feels_like')
  Temperature feelsLike;
  @JsonKey(fromJson: _numberToDouble)
  double pressure;
  @JsonKey(fromJson: _numberToDouble)
  double humidity;
  @JsonKey(fromJson: _numberToDouble)
  double uvi;
  @JsonKey(name: 'wind_speed', fromJson: _numberToDouble)
  double windSpeed;
  @JsonKey(name: 'wind_deg', fromJson: _numberToDouble)
  double windDeg;
  List<Weather> weather;
  @JsonKey(fromJson: _numberToDouble)
  double clouds;
  @JsonKey(fromJson: _numberToDouble)
  double rain;
  ForecastInfo({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.uvi,
    this.windSpeed,
    this.windDeg,
    this.weather,
    this.clouds,
    this.rain,
  });

  factory ForecastInfo.fromJson(Map<String, dynamic> json) =>
      _$ForecastInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Temperature {
  @JsonKey(fromJson: _numberToDouble)
  double day;
  @JsonKey(fromJson: _numberToDouble)
  double min;
  @JsonKey(fromJson: _numberToDouble)
  double max;
  @JsonKey(fromJson: _numberToDouble)
  double night;
  @JsonKey(fromJson: _numberToDouble)
  double eve;
  @JsonKey(fromJson: _numberToDouble)
  double morn;
  Temperature({
    this.day,
    this.min,
    this.max,
    this.night,
    this.eve,
    this.morn,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) =>
      _$TemperatureFromJson(json);
  Map<String, dynamic> toJson() => _$TemperatureToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CurrentInfo {
  @JsonKey(fromJson: _numberToDate)
  DateTime dt;
  @JsonKey(fromJson: _numberToDate)
  DateTime sunrise;
  @JsonKey(fromJson: _numberToDate)
  DateTime sunset;
  @JsonKey(fromJson: _numberToDouble)
  double temp;
  @JsonKey(name: 'feels_like', fromJson: _numberToDouble)
  double feelsLike;
  int pressure;
  @JsonKey(fromJson: _numberToDouble)
  double humidity;
  @JsonKey(fromJson: _numberToDouble)
  double uvi;
  @JsonKey(name: 'wind_speed', fromJson: _numberToDouble)
  double windSpeed;
  @JsonKey(name: 'wind_deg', fromJson: _numberToDouble)
  double windDeg;
  List<Weather> weather;
  CurrentInfo({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.uvi,
    this.windSpeed,
    this.windDeg,
    this.weather,
  });

  factory CurrentInfo.fromJson(Map<String, dynamic> json) =>
      _$CurrentInfoFromJson(json);
  Map<String, dynamic> toJson() => _$CurrentInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Weather {
  int id;
  String main;
  String description;
  String icon;
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

double _numberToDouble(dynamic number) {
  if (number == null) return 0.0;
  if (number is double) {
    return number;
  } else {
    return double.tryParse(number.toString());
  }
}

DateTime _numberToDate(dynamic number) {
  if (number is int) {
    return DateTime.fromMillisecondsSinceEpoch(number * 1000);
  } else {
    return DateTime.now();
  }
}
