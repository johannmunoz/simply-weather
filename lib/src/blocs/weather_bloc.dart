import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/src/models/search_model.dart';
import 'package:weather_app/src/models/weather_Item.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc {
  final _repository = Repository();
  final _weatherListFetcher = PublishSubject<List<WeatherItem>>();
  final _searchListFetcher = PublishSubject<SearchModel>();
  bool _updateButton = false;

  Stream<List<WeatherItem>> get getListWeather => _weatherListFetcher.stream;

  Stream<SearchModel> get getListLocations => _searchListFetcher.stream;

  bool get updateButton => _updateButton;

  void enableUpdate() {
    _updateButton = false;
  }

  void disableUpdate() {
    _updateButton = true;
  }

  fetchWeatherList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> locationsJson = prefs.getStringList('locations') ?? [];
    final locations =
        locationsJson.map((location) => SearchInfo.fromJson(location)).toList();
    List<WeatherItem> weatherList =
        await Future.wait(locations.map((location) async {
      final weather = await _repository.fetchWeather(
          location.coord.lat, location.coord.lon);
      return WeatherItem.fromModel(weather, location);
    }));

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
