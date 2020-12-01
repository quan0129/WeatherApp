import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherApp/events/settings_event.dart';
import 'package:weatherApp/states/setting_state.dart';

class SettingsBloc extends Bloc<SettingEvent, SettingsState> {
  SettingsBloc()
      : super(SettingsState(temperatureUnit: TemperatureUnit.celsius));

  @override
  Stream<SettingsState> mapEventToState(SettingEvent settingsEvent) async* {
    if (settingsEvent is SettingEventToggleUnit) {
      final newSettingState = SettingsState(
          temperatureUnit: state.temperatureUnit == TemperatureUnit.celsius
              ? TemperatureUnit.fahrenheit
              : TemperatureUnit.celsius);
      yield newSettingState;
    }
  }
}
