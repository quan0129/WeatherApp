import 'package:equatable/equatable.dart';

enum WeatherCondition {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown
}

class Weather extends Equatable {
  final WeatherCondition weatherCondition;
  final String formattedCondition;
  final double minTemp;
  final double temp;
  final double maxTemp;
  final int locationId;
  final String created;
  final DateTime lasUpdated;
  final String location;
  // contructor
  const Weather({
    this.weatherCondition,
    this.formattedCondition,
    this.minTemp,
    this.temp,
    this.maxTemp,
    this.locationId,
    this.created,
    this.lasUpdated,
    this.location,
  });
  @override
  List<Object> get props => [
        weatherCondition,
        formattedCondition,
        minTemp,
        temp,
        maxTemp,
        created,
        locationId,
        location,
      ];

  // convert json to string
  factory Weather.fromJson(dynamic jsonObject) {
    final consolidatedWeather = jsonObject['consonlidated_weather'][0];
    return Weather(
        weatherCondition: _mapStringToWeatherCondition(
                consolidatedWeather['weather_state_abbr']) ??
            '',
        formattedCondition: consolidatedWeather['weather_state_name'] ?? '',
        minTemp: consolidatedWeather['min_temp'] as double,
        temp: consolidatedWeather['the_temp'] as double,
        maxTemp: consolidatedWeather['max_temp'] as double,
        locationId: jsonObject['woeid'] as int,
        created: consolidatedWeather['created'],
        lasUpdated: DateTime.now(),
        location: jsonObject['title']);
  }

  // map string with weather
  static WeatherCondition _mapStringToWeatherCondition(String inputString) {
    Map<String, WeatherCondition> map = {
      'sn': WeatherCondition.snow,
      'sl': WeatherCondition.sleet,
      'h': WeatherCondition.hail,
      't': WeatherCondition.thunderstorm,
      'hr': WeatherCondition.heavyRain,
      'lr': WeatherCondition.lightRain,
      's': WeatherCondition.showers,
      'hc': WeatherCondition.heavyCloud,
      'lc': WeatherCondition.lightCloud,
      'c': WeatherCondition.clear
    };
    return map[inputString] ?? WeatherCondition.unknown;
  }
}
