import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestore_data_source_impl.dart';
import '../../models/note.dart';

abstract class FireStoreDataSource {
  factory FireStoreDataSource(FirebaseFirestore fireStore) = FireStoreDataSourceImpl;

  Future<List<Note>> getNotes();
  Future<void> createNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(String noteId);
}