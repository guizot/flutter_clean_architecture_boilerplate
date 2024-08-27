import 'package:equatable/equatable.dart';

abstract class GraphQLNotesCubitState extends Equatable {
  const GraphQLNotesCubitState();

  @override
  List<Object?> get props => [];
}

class GraphQLNotesInitial extends GraphQLNotesCubitState {}

class GraphQLNotesStateLoading extends GraphQLNotesCubitState {}

class GraphQLNotesStateLoaded extends GraphQLNotesCubitState {}

class GraphQLNotesStateEmpty extends GraphQLNotesCubitState {}

class GraphQLNotesStateError extends GraphQLNotesCubitState {
  final String message;
  const GraphQLNotesStateError({required this.message});

  @override
  List<Object?> get props => [message];
}