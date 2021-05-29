import 'package:flutter/material.dart';
import 'package:weather_for_runners/repository/settings_repository.dart';

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
            RadioListTile(value: 'Yandex', groupValue: widget.settingsRepository.remoteServerName, onChanged: _changeServer),
            RadioListTile(value: 'VisualCrossing', groupValue: widget.settingsRepository.remoteServerName, onChanged: _changeServer)
          ],
        ),
      ),
    );
  }
}
