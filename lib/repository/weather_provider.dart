// Project imports:
import 'package:weather_for_runners/model/weather_condition.dart';

abstract class WeatherProvider {
  Future<Map<DateTime, WeatherCondition>> loadPredictions(double latitude, double longitude);
}
