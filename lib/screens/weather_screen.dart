import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherApp/blocs/them_bloc.dart';
import 'package:weatherApp/blocs/weather_bloc.dart';
import 'package:weatherApp/events/theme_event.dart';
import 'package:weatherApp/events/weather_event.dart';
import 'package:weatherApp/screens/city_search_screen.dart';
import 'package:weatherApp/screens/setting_screen.dart';
import 'package:weatherApp/screens/temperature_widget.dart';
import 'package:weatherApp/states/them_state.dart';
import 'package:weatherApp/states/weather_state.dart';

class WeatherScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeatherScreen();
}

class _WeatherScreen extends State<WeatherScreen> {
  Completer<void> _completer;
  @override
  void initState() {
    super.initState();
    _completer = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WEATHER APP"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // Navigate Screen Setting
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingScreen()));
              }),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final typedCity = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CitySearchScreen()));
                if (typedCity != null) {
                  BlocProvider.of<WeatherBloc>(context)
                      .add(WeatherEventRequest(city: typedCity));
                }
              })
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, weatherState) {
            if (weatherState is WeatherStateSuccess) {
              BlocProvider.of<ThemeBloc>(context).add(ThemeEventWeatherChanged(
                  weatherCondition: weatherState.weather.weatherCondition));
            }
          },
          builder: (context, weatherState) {
            if (weatherState is WeatherStateLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (weatherState is WeatherStateSuccess) {
              final weather = weatherState.weather;
              return BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, themeState) {
                return RefreshIndicator(
                  child: Container(
                    color: themeState.backgroundColor,
                    child: ListView(
                      children: <Widget>[
                        Column(
                          children: [
                            Text(
                              weather.location,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: themeState.textColor),
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                            Center(
                              child: Text(
                                'Update : ${TimeOfDay.fromDateTime(weather.lasUpdated).format(context)}',
                                style: TextStyle(
                                    fontSize: 16, color: themeState.textColor),
                              ),
                            ),
                            TemperuteWidget(weather: weather)
                          ],
                        )
                      ],
                    ),
                  ),
                  // onRefresh: () {
                  //   BlocProvider.of<WeatherBloc>(context)
                  //       .add(WeatherEventRefresh(city: weather.location));
                  // }
                );
              });
            }
            if (weatherState is WeatherStateFailure) {
              return Text("Something Wrong");
            }
            return Center(
              child: Text(
                'Select a location first !',
                style: TextStyle(fontSize: 30),
              ),
            );
          },
        ),
      ),
    );
  }
}
