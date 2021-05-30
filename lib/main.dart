// Flutter imports:
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:weather_for_runners/repository/settings_repository.dart';
import 'package:weather_for_runners/repository/visual_crossing_weather_provider.dart';
import 'package:weather_for_runners/repository/weather_provider.dart';
import 'package:weather_for_runners/repository/yandex_weather_provider.dart';
import 'package:weather_for_runners/settings_page.dart';
import 'home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = SettingsRepository();
  await settings.loaded;
  GetIt.instance.registerSingleton(settings);
  GetIt.instance.registerSingleton<WeatherProvider>(settings.remoteServerName == YandexWeatherProvider.providerName ? YandexWeatherProvider() : VisualCrossingWeatherProvider());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather for runners',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
        onGenerateRoute: (routeSettings) {
          Route<dynamic>? result;
          switch (routeSettings.name) {
            case '/':
              result = MaterialPageRoute(settings: routeSettings, builder: (context) => const HomePage());
              break;
            case SettingsPage.routeName:
              result = MaterialPageRoute(settings: routeSettings, builder: (context) => const SettingsPage());
              break;
          }
          return result;
        });
  }
}
