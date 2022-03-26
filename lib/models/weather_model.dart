

import 'package:weather_app/utilities/weather_util.dart';

class WeatherModel {
  final String cityName;
  final double kelvin;
  final int celcius;
  final String icon;
  final String message;
 

  WeatherModel({
    required this.cityName,
    required this.kelvin,
    required this.celcius,
    required this.icon,
    required this.message,
  
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        cityName: json['name'],
        kelvin: json['main']['temp'],
        celcius: WeatherUtil.kelvinToCelcius(json['main']['temp']),
        icon: WeatherUtil.getWeatherIcon((json['main']['temp']).round()),
        message: WeatherUtil.getWeatherMessage(
            WeatherUtil.kelvinToCelcius(json['main']['temp'])),
      );
}
