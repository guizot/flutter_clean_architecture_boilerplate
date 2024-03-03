import 'package:equatable/equatable.dart';

abstract class SettingCubitState extends Equatable {
  const SettingCubitState();

  @override
  List<Object?> get props => [];
}

class SettingInitial extends SettingCubitState {}

class SettingStateLoading extends SettingCubitState {}

class SettingStateLoaded extends SettingCubitState {}

class SettingStateError extends SettingCubitState {
  final String message;
  const SettingStateError({required this.message});

  @override
  List<Object?> get props => [message];
}