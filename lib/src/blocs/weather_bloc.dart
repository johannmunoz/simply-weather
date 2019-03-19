import 'dart:async';
import 'package:weather_app/src/models/weather_model.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc {
  final _repository = Repository();
  final _weatherFetcher = PublishSubject<WeatherModel>();
  final _weatherListFetcher = PublishSubject<List<WeatherModel>>();
  bool _isLoading;

  Observable<WeatherModel> get getWeather => _weatherFetcher.stream;
  Observable<List<WeatherModel>> get getListWeather =>
      _weatherListFetcher.stream;

  bool get isLoading => _isLoading;

  fetchWeather(String location) async {
    _isLoading = true;
    WeatherModel weatherModel = await _repository.fetchWeather(location);
    _weatherFetcher.sink.add(weatherModel);
    _isLoading = false;
  }

  fetchWeatherList(List<String> locations) async {
    List<WeatherModel> weatherList = await Future.wait(
        locations.map((location) => _repository.fetchWeather(location)));

    _weatherListFetcher.sink.add(weatherList);
  }

  dispose() {
    _weatherFetcher.close();
    _weatherListFetcher.close();
  }
}

final bloc = WeatherBloc();
