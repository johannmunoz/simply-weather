import 'package:weather_app/src/models/weather_model.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc {
  final _repository = Repository();
  final _weatherFetcher = PublishSubject<WeatherModel>();
  bool _isLoading;

  Observable<WeatherModel> get getWeather => _weatherFetcher.stream;

  bool get isLoading => _isLoading;

  fetchWeather(String location) async {
    _isLoading = true;
    WeatherModel weatherModel = await _repository.fetchWeather(location);
    _weatherFetcher.sink.add(weatherModel);
    _isLoading = false;
  }

  dispose() {
    _weatherFetcher.close();
  }
}

final bloc = WeatherBloc();
