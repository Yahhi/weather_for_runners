// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import 'package:weather_for_runners/model/weather_condition.dart';
import 'package:weather_for_runners/repository/weather_provider.dart';
import 'package:weather_for_runners/services/ext_date_time.dart';

class VisualCrossingWeatherProvider extends WeatherProvider {
  static const _apiKey = 'fb33efb33cmsh681aecaeeeb8001p142a0djsn5535a7f05e6d';

  @override
  Future<Map<DateTime, WeatherCondition>> loadPredictions(double? latitude, double? longitude) async {
    final url = Uri.https('visual-crossing-weather.p.rapidapi.com', '/forecast', {'location': '$latitude,$longitude', 'aggregateHours': '1', 'unitGroup': 'metric', 'contentType': 'json'});
    final response = await http.get(url, headers: {'X-RapidAPI-Key': _apiKey, 'x-rapidapi-host': 'visual-crossing-weather.p.rapidapi.com', 'useQueryString': 'true'});
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final values = (jsonResponse['locations'] as Map<String, dynamic>).values.first['values'] as List<dynamic>;
      final result = <DateTime, WeatherCondition>{};
      for (var value in values) {
        try {
          final valueDate = DateTime.parse(value['datetimeStr'] as String).toLocal();
          final temperature = value['temp'] as double;
          final windSpeed = value['wspd'] as double;
          final windGust = value['wgust'] as double;
          final wdir = value['wdir'] as double;
          result[valueDate.hourStart] = WeatherCondition.withAngle(windDirectionAngle: wdir, windSpeed: windSpeed, temperature: temperature, windGust: windGust);
        } catch (e) {
          print(e);
        }
      }
      return result;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return {};
    }
  }

  static const providerName = 'VisualCrossing';
}
