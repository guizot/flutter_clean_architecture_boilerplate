import 'package:equatable/equatable.dart';

abstract class HomeCubitState extends Equatable {
  const HomeCubitState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeCubitState {}

class HomeStateLoading extends HomeCubitState {}

class HomeStateLoaded extends HomeCubitState {

}

class HomeStateError extends HomeCubitState {
  final String message;
  const HomeStateError({required this.message});

  @override
  List<Object?> get props => [message];
}