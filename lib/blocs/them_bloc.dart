import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherApp/events/theme_event.dart';
import 'package:weatherApp/models/weather.dart';
import 'package:weatherApp/states/them_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(
            backgroundColor: Colors.lightBlue, textColor: Colors.black));
  @override
  Stream<ThemeState> mapEventToState(ThemeEvent themeEvent) async* {
    ThemeState newThemstate;
    if (themeEvent is ThemeEventWeatherChanged) {
      final weatherCondition = themeEvent.weatherCondition;
      if (weatherCondition == WeatherCondition.clear ||
          weatherCondition == WeatherCondition.lightCloud) {
        newThemstate =
            ThemeState(backgroundColor: Colors.yellow, textColor: Colors.black);
      } else if (weatherCondition == WeatherCondition.hail ||
          weatherCondition == WeatherCondition.sleet ||
          weatherCondition == WeatherCondition.snow) {
        newThemstate = ThemeState(
            backgroundColor: Colors.lightBlue, textColor: Colors.white);
      } else if (weatherCondition == WeatherCondition.heavyCloud) {
        newThemstate =
            ThemeState(backgroundColor: Colors.grey, textColor: Colors.black);
      } else if (weatherCondition == WeatherCondition.heavyRain ||
          weatherCondition == WeatherCondition.lightRain ||
          weatherCondition == WeatherCondition.showers) {
        newThemstate =
            ThemeState(backgroundColor: Colors.indigo, textColor: Colors.white);
      } else if (weatherCondition == WeatherCondition.thunderstorm) {
        newThemstate = ThemeState(
            backgroundColor: Colors.deepPurple, textColor: Colors.white);
      } else {
        newThemstate = ThemeState(
            backgroundColor: Colors.lightBlue, textColor: Colors.white);
      }
      yield newThemstate;
    }
  }
}
