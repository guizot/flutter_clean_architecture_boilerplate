import 'package:flutter_clean_architecture/data/data_source/remote/firestore_data_source.dart';
import 'package:flutter_clean_architecture/data/models/note.dart';
import 'package:flutter_clean_architecture/domain/repositories/firestore_repo.dart';

class FireStoreRepoImpl implements FireStoreRepo {

  /// REGION: INIT IMPLEMENTOR
  final FireStoreDataSource fireStoreDataSource;

  FireStoreRepoImpl({
    required this.fireStoreDataSource,
  });

  @override
  Future<void> createNote(Note note) {
    return fireStoreDataSource.createNote(note);
  }

  @override
  Future<void> deleteNote(String noteId) {
    return fireStoreDataSource.deleteNote(noteId);
  }

  @override
  Future<List<Note>> getNotes() {
    return fireStoreDataSource.getNotes();
  }

  @override
  Future<void> updateNote(Note note) {
    return fireStoreDataSource.updateNote(note);
  }

}
