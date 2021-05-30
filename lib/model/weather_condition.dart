class WeatherCondition {
  WeatherCondition({required this.windDirection, required this.windSpeed, required this.temperature, this.windGust = 0.0});

  factory WeatherCondition.withAngle({required double windDirectionAngle, required double windSpeed, required double temperature, double windGust = 0.0}) {
    WindDirection? direction;
    const initialBorder = 22.5;
    for (var i = 0; i < 8; i++) {
      if (windDirectionAngle < initialBorder + i * 45) {
        direction = WindDirection.values[i];
        break;
      }
    }
    direction ??= WindDirection.north;
    return WeatherCondition(windDirection: direction, windSpeed: windSpeed, temperature: temperature, windGust: windGust);
  }

  factory WeatherCondition.withLetter({required String windDirectionLetter, required double windSpeed, required double temperature, double windGust = 0.0}) {
    WindDirection? direction;
    switch (windDirectionLetter) {
      case 'e':
        direction = WindDirection.east;
        break;
      case 'w':
        direction = WindDirection.west;
        break;
      case 's':
        direction = WindDirection.south;
        break;
      case 'n':
        direction = WindDirection.north;
        break;
      case 'ne':
        direction = WindDirection.northEast;
        break;
      case 'nw':
        direction = WindDirection.northWest;
        break;
      case 'se':
        direction = WindDirection.southEast;
        break;
      case 'sw':
        direction = WindDirection.southWest;
        break;
    }
    direction ??= WindDirection.calm;
    return WeatherCondition(windDirection: direction, windSpeed: windSpeed, temperature: temperature, windGust: windGust);
  }

  final WindDirection windDirection;
  final double windSpeed;
  final double windGust; // скорость порывов ветра
  final double temperature;
}

enum WindDirection { north, northWest, west, southWest, south, southEast, east, northEast, calm }

extension WindText on WindDirection {
  String get text {
    switch (this) {
      case WindDirection.south:
        return 'S';
      case WindDirection.southWest:
        return 'SW';
      case WindDirection.southEast:
        return 'SE';
      case WindDirection.north:
        return 'N';
      case WindDirection.northWest:
        return 'NW';
      case WindDirection.northEast:
        return 'NE';
      case WindDirection.east:
        return 'E';
      case WindDirection.west:
        return 'W';
      case WindDirection.calm:
      default:
        return 'calm';
    }
  }
}
