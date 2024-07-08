import 'package:equatable/equatable.dart';

abstract class NotesCubitState extends Equatable {
  const NotesCubitState();

  @override
  List<Object?> get props => [];
}

class NotesInitial extends NotesCubitState {}

class NotesStateLoading extends NotesCubitState {}

class NotesStateLoaded extends NotesCubitState {}

class NotesStateEmpty extends NotesCubitState {}

class NotesStateError extends NotesCubitState {
  final String message;
  const NotesStateError({required this.message});

  @override
  List<Object?> get props => [message];
}