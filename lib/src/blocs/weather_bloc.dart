import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/src/models/search_model.dart';
import 'package:weather_app/src/models/weather_item.dart';

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
    DateTime timeNow = DateTime.now();

    List<String> locationsJson = prefs.getStringList('locationsList') ?? [];
    List<String> fetchedWeatherListJson =
        prefs.getStringList('weatherList') ?? [];
    String lastUpdateJson = prefs.getString('lastUpdate');

    if (lastUpdateJson != null) {
      DateTime lastUpdate = DateTime.parse(lastUpdateJson);
      if (timeNow.isBefore(lastUpdate.add(Duration(hours: 1)))) {
        if (fetchedWeatherListJson.isNotEmpty && locationsJson.isNotEmpty) {
          if (fetchedWeatherListJson.length == locationsJson.length) {
            final weatherList = fetchedWeatherListJson
                .map((e) => WeatherItem.fromJson(e))
                .toList();
            _weatherListFetcher.sink.add(weatherList);
            return;
          }
        }
      }
    }

    final locations =
        locationsJson.map((location) => SearchInfo.fromJson(location)).toList();

    List<WeatherItem> weatherList =
        await Future.wait(locations.map((location) async {
      final weather = await _repository.fetchWeather(
          location.coord.lat, location.coord.lon);
      return WeatherItem.fromModel(weather, location);
    }));

    final weatherListJson = weatherList.map((e) => e.toJson()).toList();

    prefs.setStringList('weatherList', weatherListJson);
    prefs.setString('lastUpdate', timeNow.toIso8601String());

    _weatherListFetcher.sink.add(weatherList);
    return;
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
