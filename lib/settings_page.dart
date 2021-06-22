// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:weather_for_runners/repository/settings_repository.dart';
import 'package:weather_for_runners/repository/visual_crossing_weather_provider.dart';
import 'package:weather_for_runners/repository/weather_provider.dart';
import 'package:weather_for_runners/repository/yandex_weather_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const routeName = '/settings';

  @override
  State<StatefulWidget> createState() {
    return _SettingsPageState();
  }
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsRepository get settingsRepository => GetIt.instance.get<SettingsRepository>();

  void _changeServer(String? value) {
    if (value == null) return;
    settingsRepository.remoteServerName = value;
    GetIt.instance.unregister<WeatherProvider>();
    GetIt.instance.registerSingleton<WeatherProvider>(value == YandexWeatherProvider.providerName ? YandexWeatherProvider() : VisualCrossingWeatherProvider());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('Weather API provider'),
            RadioListTile(
              value: YandexWeatherProvider.providerName,
              groupValue: settingsRepository.remoteServerName,
              onChanged: _changeServer,
              title: const Text(YandexWeatherProvider.providerName),
            ),
            RadioListTile(
                value: VisualCrossingWeatherProvider.providerName,
                groupValue: settingsRepository.remoteServerName,
                onChanged: _changeServer,
                title: const Text(VisualCrossingWeatherProvider.providerName))
          ],
        ),
      ),
    );
  }
}
