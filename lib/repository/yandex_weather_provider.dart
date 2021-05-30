// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import 'package:weather_for_runners/model/weather_condition.dart';
import 'package:weather_for_runners/repository/weather_provider.dart';
import 'package:weather_for_runners/services/ext_date_time.dart';

class YandexWeatherProvider extends WeatherProvider {
  static const _apiKey = '92071834-c1b4-4fcc-8705-6242ee383094';

  @override
  Future<Map<DateTime, WeatherCondition>> loadPredictions(double latitude, double longitude) async {
    final url = Uri.https('api.weather.yandex.ru', '/v2/forecast', {'lat': latitude.toString(), 'lon': longitude.toString()});
    print(url);
    final response = await http.get(url, headers: {'X-Yandex-API-Key': _apiKey});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final dates = jsonResponse['forecasts'] as List<dynamic>;
      final result = <DateTime, WeatherCondition>{};
      for (var date in dates) {
        final hours = date['hours'] as List<dynamic>;
        for (var hour in hours) {
          try {
            final valueDate = DateTime.fromMillisecondsSinceEpoch((hour['hour_ts'] as int) * 1000);
            final temperature = hour['temp'] as int;
            final windSpeed = hour['wind_speed'].toString().contains('.') ? hour['wind_speed'] as double : (hour['wind_speed'] as int).toDouble();
            final wdir = hour['wind_dir'] as String;
            final windGust = hour['wind_gust'].toString().contains('.') ? hour['wind_gust'] as double : (hour['wind_gust'] as int).toDouble();
            result[valueDate.hourStart] = WeatherCondition.withLetter(windDirectionLetter: wdir, windSpeed: windSpeed, temperature: temperature.toDouble(), windGust: windGust);
          } catch (e) {
            print(e);
          }
        }
      }
      return result;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return {DateTime.now().hourStart: WeatherCondition(windSpeed: 10, windDirection: WindDirection.north, temperature: 10)};
  }

  static const providerName = 'YandexWeather';
}
