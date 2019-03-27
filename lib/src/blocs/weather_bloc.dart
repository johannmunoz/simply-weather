import 'dart:async';
import 'package:weather_app/src/models/search_model.dart';
import 'package:weather_app/src/models/weather_model.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc {
  final _repository = Repository();
  final _weatherListFetcher = PublishSubject<List<WeatherModel>>();
  final _searchListFetcher = PublishSubject<SearchModel>();

  Observable<List<WeatherModel>> get getListWeather =>
      _weatherListFetcher.stream;

  Observable<SearchModel> get getListLocations => _searchListFetcher.stream;

  fetchWeatherList(List<String> locations) async {
    List<WeatherModel> weatherList = await Future.wait(
        locations.map((location) => _repository.fetchWeather(location)));

    _weatherListFetcher.sink.add(weatherList);
  }

  fetchSearchList(String location) async {
    SearchModel searchList = await _repository.fetchLocations(location);
    _searchListFetcher.sink.add(searchList);
  }

  dispose() {
    _weatherListFetcher.close();
    _searchListFetcher.close();
  }
}

final bloc = WeatherBloc();
