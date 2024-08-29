import '../../data/models/note.dart';
import '../../data/models/note_response.dart';

abstract class GraphQLRepo {

  // Remote Data Source
  Future<List<NoteModel>> getNotes();
  Future<void> createNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(String noteId);
  Future<String> getToken();

  // Local Data Source
  Future<void> setToken(String token);

}