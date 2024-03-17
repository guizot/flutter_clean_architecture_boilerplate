import 'package:equatable/equatable.dart';

abstract class GithubCubitState extends Equatable {
  const GithubCubitState();

  @override
  List<Object?> get props => [];
}

class GithubInitial extends GithubCubitState {}

class GithubStateLoading extends GithubCubitState {}

class GithubStateLoaded extends GithubCubitState {}

class GithubStateEmpty extends GithubCubitState {}

class GithubStateError extends GithubCubitState {
  final String message;
  const GithubStateError({required this.message});

  @override
  List<Object?> get props => [message];
}