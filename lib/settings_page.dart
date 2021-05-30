// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:weather_for_runners/repository/settings_repository.dart';
import 'package:weather_for_runners/repository/visual_crossing_weather_provider.dart';
import 'package:weather_for_runners/repository/yandex_weather_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required this.settingsRepository}) : super(key: key);

  static const routeName = '/settings';

  final SettingsRepository settingsRepository;

  @override
  State<StatefulWidget> createState() {
    return _SettingsPageState();
  }
}

class _SettingsPageState extends State<SettingsPage> {
  void _changeServer(String? value) {
    if (value == null) return;
    widget.settingsRepository.remoteServerName = value;
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
              groupValue: widget.settingsRepository.remoteServerName,
              onChanged: _changeServer,
              title: const Text(YandexWeatherProvider.providerName),
            ),
            RadioListTile(
                value: VisualCrossingWeatherProvider.providerName,
                groupValue: widget.settingsRepository.remoteServerName,
                onChanged: _changeServer,
                title: const Text(VisualCrossingWeatherProvider.providerName))
          ],
        ),
      ),
    );
  }
}
