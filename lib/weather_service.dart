import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather.dart';

class WeatherService {
final String apiKey = 'eb286eee90598fb46d56ef998cadb7cf';
final String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';

Future<Weather> fetchWeather(String city) async {
  try {
    final response = await http.get(Uri.parse('$apiUrl?q=$city&units=metric&appid=$apiKey'));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Weather.fromJson(json);
    } else {
      throw Exception('Failed to load weather: ${response.body}');
    }
  } catch (e) {
    print('Error fetching weather: $e');
    throw Exception('Failed to load weather');
  }
}
}
