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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[200]!, Colors.blue[900]!],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            children: [
              AppBar(
                title: const Text('Weather App'),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Expanded(
                child: SingleChildScrollView(
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
                                icon: const Icon(Icons.search),
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
                      const SizedBox(height: 20),
                      Consumer<WeatherProvider>(
                        builder: (context, weatherProvider, child) {
                          if (weatherProvider.loading) {
                            return const CircularProgressIndicator();
                          } else if (weatherProvider.weather == null) {
                            return const Text(
                              'No weather data',
                              style: TextStyle(color: Colors.white),
                            );
                          } else {
                            final weather = weatherProvider.weather!;
                            return Card(
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      weather.cityName,
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      '${weather.temperature}°C',
                                      style: const TextStyle(
                                        fontSize: 26,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      weather.description,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Image.network(
                                      'http://openweathermap.org/img/w/${weather.icon}.png',
                                      scale: 0.5,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),himla
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
