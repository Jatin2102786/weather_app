import 'package:flutter/material.dart';
import 'weather.dart';
import 'package:weather_app/weather_service.dart';
class WeatherProvider with ChangeNotifier {
Weather? _weather;
bool _loading = false;

Weather? get weather => _weather;
bool get loading => _loading;

WeatherService _weatherService = WeatherService();

Future<void> fetchWeather(String city) async {
  _loading = true;
  notifyListeners();
  try {
    _weather = await _weatherService.fetchWeather(city);
  } catch (e) {
    print('Error fetching weather: $e');
    _weather = null;
  }
  _loading = false;
  notifyListeners();
}
}
