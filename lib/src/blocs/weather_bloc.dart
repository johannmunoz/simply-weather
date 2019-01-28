import 'package:weather_app/src/models/weather_model.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc {
  final _repository = Repository();
  final _weatherFetcher = PublishSubject<WeatherModel>();

  Observable<WeatherModel> get getWeather => _weatherFetcher.stream;

  fetchWeather() async {
    WeatherModel weatherModel = await _repository.fetchWeather();
    _weatherFetcher.sink.add(weatherModel);
  }

  dispose() {
    _weatherFetcher.close();
  }
}

final bloc = WeatherBloc();
