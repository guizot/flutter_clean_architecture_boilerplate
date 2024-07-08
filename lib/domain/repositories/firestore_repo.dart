import '../../data/models/note.dart';

abstract class FireStoreRepo {
  Future<List<Note>> getNotes();
  Future<void> createNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(String noteId);
}