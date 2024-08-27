import 'package:graphql_flutter/graphql_flutter.dart';
import '../../models/note.dart';
import '../../models/note_response.dart';
import 'graphql_data_source_impl.dart';

abstract class GraphQLDataSource {
  factory GraphQLDataSource(GraphQLClient client) = GraphQLDataSourceImpl;

  Future<List<NoteModel>> getNotes();
  Future<void> createNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(String noteId);
}