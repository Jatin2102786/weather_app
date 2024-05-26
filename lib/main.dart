import 'package:flutter/material.dart';
import 'weather_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WeatherScreen(),
      ),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
          Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter City Name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    final city = _controller.text;
                    if (city.isNotEmpty) {
                      Provider.of<WeatherProvider>(context, listen: false).fetchWeather(city);
                    }
                  },
                ),
              ),
            ),
          ),
          ),
            SizedBox(height: 20),
            Consumer<WeatherProvider>(
              builder: (context, weatherProvider, child) {
                if (weatherProvider.loading) {
                  return CircularProgressIndicator();
                } else if (weatherProvider.weather == null) {
                  return Text('No weather data');
                } else {
                  final weather = weatherProvider.weather!;
                  return Column(
                    children: [
                      Text(
                        weather.cityName,
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        '${weather.temperature}°C',
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        weather.description,
                        style: TextStyle(fontSize: 24),
                      ),
                      Image.network(
                        'http://openweathermap.org/img/w/${weather.icon}.png',
                        scale: 0.5,
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}