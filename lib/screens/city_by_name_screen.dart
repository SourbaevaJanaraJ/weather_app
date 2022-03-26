import 'package:flutter/material.dart';
import 'package:weather_app/data/providers/weather_provider.dart';

class CityByNameScreen extends StatefulWidget {
  final String cityName;
  final int temp;
  const CityByNameScreen({Key? key, 
  required this.cityName, 
  required this.temp}) : super(key: key);

  @override
  _CityByNameScreenState createState() => _CityByNameScreenState();
}

class _CityByNameScreenState extends State<CityByNameScreen> {
  Map<String, dynamic> ?_cityWeatherData;
  int _celcius = 0;

  @override
  void initState() {
    super.initState();
    getCityWeather();
  }

  Future<void> getCityWeather() async {
    _cityWeatherData =
        await WeatherProvider().getWeatherData(city: widget.cityName);
    _celcius = (_cityWeatherData?['main']['temp'] - 273.15).round();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('city by name: ${widget.cityName}'),
            Text('city by name: $_celcius'),
          ],
        ),
      ),
    );
  }
}
