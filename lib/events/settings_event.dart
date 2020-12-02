import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {}

class SettingsEventToggleUnit extends SettingsEvent {
  @override
  List<Object> get props => [];
}
