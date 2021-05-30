// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:weather_for_runners/repository/visual_crossing_weather_provider.dart';

class SettingsRepository {
  SettingsRepository() {
    loaded = _loadData();
  }

  static const _serverNameKey = 'server';

  late SharedPreferences _prefs;

  late Future<bool> loaded;

  String? _remoteServerName;
  String get remoteServerName => _remoteServerName ?? VisualCrossingWeatherProvider.providerName;
  set remoteServerName(String value) {
    _remoteServerName = value;
    _prefs.setString(_serverNameKey, value);
  }

  Future<bool> _loadData() async {
    _prefs = await SharedPreferences.getInstance();
    _remoteServerName = _prefs.getString(_serverNameKey);
    return true;
  }
}
