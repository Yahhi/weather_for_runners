// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:weather_for_runners/home_page.dart';
import 'package:weather_for_runners/model/weather_condition.dart';
import 'package:weather_for_runners/repository/weather_provider.dart';
import 'package:weather_for_runners/services/ext_date_time.dart';

class MockProvider extends Mock implements WeatherProvider {}

void main() {
  final repository = MockProvider();

  setUpAll(() {
    final service = GetIt.instance;
    service.registerSingleton<WeatherProvider>(repository);
  });

  testWidgets('отображение данных о погоде', (WidgetTester tester) async {
    when(repository.loadPredictions(any, any)).thenAnswer((_) async {
      return {DateTime.now().hourStart: WeatherCondition(windDirection: WindDirection.north, temperature: 10.0, windSpeed: 3.0, windGust: 8.0)};
    });

    await tester.pumpWidget(const MaterialApp(
      home: HomePage(),
    ));
    await tester.pumpAndSettle();

    final titleText = find.text('Current weather:');
    expect(titleText, findsOneWidget);
    final weather = find.text('Ветер: 3.0 N, порывами 8.0, температура: 10.0');
    expect(weather, findsOneWidget);
  });
}
