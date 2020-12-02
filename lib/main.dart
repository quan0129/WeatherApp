import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherApp/blocs/settings_bloc.dart';
import 'package:weatherApp/blocs/them_bloc.dart';
import 'package:weatherApp/blocs/weather_bloc.dart';
import 'package:weatherApp/blocs/weather_bloc_observer.dart';
import 'package:weatherApp/models/weather.dart';
import 'package:weatherApp/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:weatherApp/screens/weather_screen.dart';
import 'package:weatherApp/states/them_state.dart';

void main() {
  Bloc.observer = WeatherBlocObserver();
  final WeatherRepository weatherRepository =
      WeatherRepository(httpClient: http.Client());
  runApp(BlocProvider<ThemeBloc>(
    create: (context) => ThemeBloc(),
    child: BlocProvider<SettingsBloc>(
      create: (context) => SettingsBloc(),
      child: MyApp(
        weatherRepository: weatherRepository,
      ),
    ),
  ));
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;
  MyApp({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themState) {
        return MaterialApp(
          title: 'Flutter Weather App with Bloc',
          home: BlocProvider(
            create: (context) =>
                WeatherBloc(weatherRepository: weatherRepository),
            child: WeatherScreen(),
          ),
        );
      },
    );
  }
}
