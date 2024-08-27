import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/note.dart';
import '../../../../data/models/note_response.dart';
import '../../../../domain/usecases/graphql_usecases.dart';
import 'graphql_notes_state.dart';

class GraphQLNotesCubit extends Cubit<GraphQLNotesCubitState> {

  /// REGION: INIT CUBIT
  final GraphQLUseCases graphQLUseCases;
  GraphQLNotesCubit({required this.graphQLUseCases}) : super(GraphQLNotesInitial());

  Future<void> createNote(Note note) {
    return graphQLUseCases.createNote(note);
  }

  Future<void> deleteNote(String noteId) {
    return graphQLUseCases.deleteNote(noteId);
  }

  Future<List<NoteModel>> getGraphQLNotes() async {
    emit(GraphQLNotesStateLoading());
    List<NoteModel> notes = await graphQLUseCases.getNotes();
    if(notes.isEmpty) {
      emit(GraphQLNotesStateEmpty());
    } else if(notes.isNotEmpty) {
      emit(GraphQLNotesStateLoaded());
    }
    return notes;
  }

  Future<void> updateNote(Note note) {
    return graphQLUseCases.updateNote(note);
  }

}