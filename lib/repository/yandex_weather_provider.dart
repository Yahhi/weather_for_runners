import 'dart:convert';

import 'package:weather_for_runners/model/weather_condition.dart';
import 'package:weather_for_runners/repository/weather_provider.dart';
import 'package:weather_for_runners/services/ext_date_time.dart';
import 'package:http/http.dart' as http;

class YandexWeatherProvider extends WeatherProvider {
  @override
  Future<Map<DateTime, WeatherCondition>> loadPredictions(double latitude, double longitude) async {
    final url = Uri.https('api.weather.yandex.ru', '/v2/informers', {'lat': latitude.toString(), 'long': longitude.toString()});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      print(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return {DateTime.now().hourStart: WeatherCondition(windSpeed: 10, windDirection: WindDirection.north, temperature: 10)};
  }
}
