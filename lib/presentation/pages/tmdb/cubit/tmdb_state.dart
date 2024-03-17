import 'package:equatable/equatable.dart';

abstract class TMDBCubitState extends Equatable {
  const TMDBCubitState();

  @override
  List<Object?> get props => [];
}

class TMDBInitial extends TMDBCubitState {}

class TMDBStateLoading extends TMDBCubitState {}

class TMDBStateLoaded extends TMDBCubitState {}

class TMDBStateEmpty extends TMDBCubitState {}

class TMDBStateError extends TMDBCubitState {
  final String message;
  const TMDBStateError({required this.message});

  @override
  List<Object?> get props => [message];
}