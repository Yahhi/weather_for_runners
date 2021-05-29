import 'package:flutter/material.dart';
import 'package:weather_for_runners/model/weather_condition.dart';
import 'package:weather_for_runners/repository/yandex_weather_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherCondition? currentWeather;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadWeather() async {
    currentWeather = (await YandexWeatherProvider().loadPredictions(0.0, 0.0)).values.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Current weather:',
            ),
            if (currentWeather != null)
              Text(
                '${currentWeather!.windSpeed} ${currentWeather!.windDirection}, temperature: ${currentWeather!.temperature}',
                style: Theme.of(context).textTheme.headline4,
              ),
          ],
        ),
      ),
    );
  }
}
