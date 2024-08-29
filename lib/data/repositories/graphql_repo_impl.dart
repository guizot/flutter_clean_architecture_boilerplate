import 'package:flutter_clean_architecture/data/core/constant/const_values.dart';
import 'package:flutter_clean_architecture/data/data_source/shared/shared_preferences_data_source.dart';
import 'package:flutter_clean_architecture/data/models/note.dart';
import '../../domain/repositories/graphql_repo.dart';
import '../data_source/remote/graphql_data_source.dart';
import '../models/note_response.dart';

class GraphQLRepoImpl implements GraphQLRepo {

  /// REGION: INIT IMPLEMENTOR
  final GraphQLDataSource graphQLDataSource;
  final SharedPreferenceDataSource sharedPreferenceDataSource;

  GraphQLRepoImpl({
    required this.graphQLDataSource,
    required this.sharedPreferenceDataSource,
  });

  @override
  Future<void> createNote(Note note) {
    return graphQLDataSource.createNote(note);
  }

  @override
  Future<void> deleteNote(String noteId) {
    return graphQLDataSource.deleteNote(noteId);
  }

  @override
  Future<List<NoteModel>> getNotes() {
    return graphQLDataSource.getNotes();
  }

  @override
  Future<void> updateNote(Note note) {
    return graphQLDataSource.updateNote(note);
  }

  @override
  Future<String> getToken() {
    return graphQLDataSource.getToken();
  }

  @override
  Future<void> setToken(String token) {
    return sharedPreferenceDataSource.setString(ConstValues.graphQLTokenKey, token);
  }

}
