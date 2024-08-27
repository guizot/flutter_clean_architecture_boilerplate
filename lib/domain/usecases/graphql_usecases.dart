import '../../data/models/note.dart';
import '../../data/models/note_response.dart';
import '../repositories/graphql_repo.dart';

class GraphQLUseCases {

  /// REGION: INIT USE CASE
  final GraphQLRepo graphQLRepo;
  GraphQLUseCases({required this.graphQLRepo});

  /// REGION: REMOTE DATA SOURCE
  Future<void> createNote(Note note) {
    return graphQLRepo.createNote(note);
  }

  Future<void> deleteNote(String noteId) {
    return graphQLRepo.deleteNote(noteId);
  }

  Future<List<NoteModel>> getNotes() {
    return graphQLRepo.getNotes();
  }

  Future<void> updateNote(Note note) {
    return graphQLRepo.updateNote(note);
  }

}