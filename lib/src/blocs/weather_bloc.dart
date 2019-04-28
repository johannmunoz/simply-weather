import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/src/models/search_model.dart';
import 'package:weather_app/src/models/weather_model.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc {
  final _repository = Repository();
  final _weatherListFetcher = PublishSubject<List<WeatherModel>>();
  final _searchListFetcher = PublishSubject<SearchModel>();
  bool _updateButton = false;

  Observable<List<WeatherModel>> get getListWeather =>
      _weatherListFetcher.stream;

  Observable<SearchModel> get getListLocations => _searchListFetcher.stream;

  bool get updateButton => _updateButton;

  void enableUpdate() {
    _updateButton = false;
  }

  void disableUpdate() {
    _updateButton = true;
  }

  fetchWeatherList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> locations = prefs.getStringList('locations') ?? [];
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
