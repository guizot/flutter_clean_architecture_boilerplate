import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/domain/usecases/firestore_usecases.dart';
import '../../../../data/models/note.dart';
import 'notes_state.dart';

class NotesCubit extends Cubit<NotesCubitState> {

  /// REGION: INIT CUBIT
  final FireStoreUseCases fireStoreUseCases;
  NotesCubit({required this.fireStoreUseCases}) : super(NotesInitial());

  Future<void> createNote(Note note) {
    return fireStoreUseCases.createNote(note);
  }

  Future<void> deleteNote(String noteId) {
    return fireStoreUseCases.deleteNote(noteId);
  }

  Future<List<Note>> getNotes() async {
    emit(NotesStateLoading());
    List<Note> notes = await fireStoreUseCases.getNotes();
    if(notes.isEmpty) {
      emit(NotesStateEmpty());
    } else if(notes.isNotEmpty) {
      emit(NotesStateLoaded());
    }
    return notes;
  }

  Future<void> updateNote(Note note) {
    return fireStoreUseCases.updateNote(note);
  }

}