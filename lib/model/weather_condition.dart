class WeatherCondition {
  WeatherCondition({required this.windDirection, required this.windSpeed, required this.temperature});

  final WindDirection windDirection;
  final double windSpeed;
  final double temperature;
}

enum WindDirection { south, southWest, southEast, north, northWest, northEast, east, west, calm }
