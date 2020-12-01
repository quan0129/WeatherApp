import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherApp/blocs/settings_bloc.dart';
import 'package:weatherApp/blocs/them_bloc.dart';
import 'package:weatherApp/models/weather.dart';
import 'package:weatherApp/states/setting_state.dart';
import 'package:weatherApp/states/them_state.dart';
import 'package:weather_icons/weather_icons.dart';

class TemperuteWidget extends StatelessWidget {
  final Weather weather;
  TemperuteWidget({Key key, @required this.weather})
      : assert(weather != null),
        super(key: key);
  int _toFahrenheit(double celcius) => ((celcius * 9 / 5) + 32).round();
  String _formattedTemperature(double temp, TemperatureUnit temperuteUnit) =>
      temperuteUnit == TemperatureUnit.fahrenheit
          ? '${_toFahrenheit(temp)} độ F'
          : '${temp.round()} độ C';
  BoxedIcon _mapWeatherConditionToIcon({WeatherCondition weatherCondition}) {
    switch (weatherCondition) {
      case WeatherCondition.clear:
      case WeatherCondition.lightCloud:
        return BoxedIcon(WeatherIcons.day_sunny);
        break;
      case WeatherCondition.hail:
      case WeatherCondition.snow:
      case WeatherCondition.sleet:
        return BoxedIcon(WeatherIcons.snow);
        break;
      case WeatherCondition.heavyCloud:
        return BoxedIcon(WeatherIcons.cloud_up);
        break;
      case WeatherCondition.heavyRain:
      case WeatherCondition.lightRain:
      case WeatherCondition.showers:
        return BoxedIcon(WeatherIcons.rain);
        break;
      case WeatherCondition.thunderstorm:
        return BoxedIcon(WeatherIcons.thunderstorm);
        break;
      case WeatherCondition.unknown:
        return BoxedIcon(WeatherIcons.sunset);
        break;
    }
    return BoxedIcon(WeatherIcons.sunset);
  }

  @override
  Widget build(BuildContext context) {
    ThemeState _themeState = BlocProvider.of<ThemeBloc>(context).state;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _mapWeatherConditionToIcon(
                weatherCondition: weather.weatherCondition),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, settingsSate) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Min temp: ${_formattedTemperature(weather.minTemp, settingsSate.temperatureUnit)}',
                        style: TextStyle(
                            fontSize: 18, color: _themeState.textColor),
                      ),
                      Text(
                        'Temp :${_formattedTemperature(weather.temp, settingsSate.temperatureUnit)}',
                        style: TextStyle(
                            fontSize: 18, color: _themeState.textColor),
                      ),
                      Text(
                        'Max Temp: ${_formattedTemperature(weather.temp, settingsSate.temperatureUnit)}',
                        style: TextStyle(
                            fontSize: 18, color: _themeState.textColor),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        )
      ],
    );
  }
}
