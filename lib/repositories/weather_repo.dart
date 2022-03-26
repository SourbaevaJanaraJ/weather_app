

import 'package:weather_app/data/providers/location_provider.dart';
import 'package:weather_app/data/providers/weather_provider.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherRepo {
  Future<WeatherModel?> getWeatherByCurrentLocation() async {
    final _position = await LocationProvider().getCurrentPosition();
    return await WeatherProvider().getWeatherByLocation(_position);
  }

  Future<WeatherModel?> getWeatherByCity(String city) async {
    return await WeatherProvider().getWeatherByCity(city);
  }
}

final WeatherRepo weatherRepo = WeatherRepo();



