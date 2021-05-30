// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:weather_for_runners/repository/settings_repository.dart';
import 'package:weather_for_runners/settings_page.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = SettingsRepository();
  await settings.loaded;
  runApp(MyApp(settingsRepository: settings));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.settingsRepository}) : super(key: key);

  final SettingsRepository settingsRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather for runners',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(settingsRepository: settingsRepository),
        onGenerateRoute: (routeSettings) {
          Route<dynamic>? result;
          switch (routeSettings.name) {
            case '/':
              result = MaterialPageRoute(settings: routeSettings, builder: (context) => HomePage(settingsRepository: settingsRepository));
              break;
            case SettingsPage.routeName:
              result = MaterialPageRoute(settings: routeSettings, builder: (context) => SettingsPage(settingsRepository: settingsRepository));
              break;
          }
          return result;
        });
  }
}
