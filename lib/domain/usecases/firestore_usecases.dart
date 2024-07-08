import '../../data/models/note.dart';
import '../repositories/firestore_repo.dart';

class FireStoreUseCases {

  /// REGION: INIT USE CASE
  final FireStoreRepo fireStoreRepo;
  FireStoreUseCases({required this.fireStoreRepo});

  /// REGION: REMOTE DATA SOURCE
  Future<void> createNote(Note note) {
    return fireStoreRepo.createNote(note);
  }

  Future<void> deleteNote(String noteId) {
    return fireStoreRepo.deleteNote(noteId);
  }

  Future<List<Note>> getNotes() {
    return fireStoreRepo.getNotes();
  }

  Future<void> updateNote(Note note) {
    return fireStoreRepo.updateNote(note);
  }

}