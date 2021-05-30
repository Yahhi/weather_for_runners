// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:geolocator/geolocator.dart';

// Project imports:
import 'package:weather_for_runners/model/weather_condition.dart';
import 'package:weather_for_runners/repository/settings_repository.dart';
import 'package:weather_for_runners/repository/visual_crossing_weather_provider.dart';
import 'package:weather_for_runners/repository/yandex_weather_provider.dart';
import 'package:weather_for_runners/settings_page.dart';
import 'services/ext_date_time.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.settingsRepository}) : super(key: key);

  final SettingsRepository settingsRepository;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherCondition? currentWeather;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    final position = await Geolocator.getLastKnownPosition();
    final Map<DateTime, WeatherCondition> predictions;
    if (widget.settingsRepository.remoteServerName == YandexWeatherProvider.providerName) {
      predictions = await YandexWeatherProvider().loadPredictions(position?.latitude ?? 0.0, position?.longitude ?? 0.0);
    } else {
      predictions = await VisualCrossingWeatherProvider().loadPredictions(position?.latitude ?? 0.0, position?.longitude ?? 0.0);
    }
    currentWeather = predictions[DateTime.now().hourStart];
    setState(() {});
  }

  Future<void> _openSettings() async {
    await Navigator.of(context).pushNamed(SettingsPage.routeName);
    await _loadWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(onPressed: _openSettings, icon: const Icon(Icons.settings)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Current weather:',
            ),
            Text(
              currentWeather == null
                  ? 'no weather data'
                  : 'Ветер: ${currentWeather!.windSpeed} ${currentWeather!.windDirection.text}, порывами ${currentWeather!.windGust}, температура: ${currentWeather!.temperature}',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
