import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_clean_architecture/data/data_source/remote/firestore_data_source.dart';
import 'package:flutter_clean_architecture/data/models/note.dart';

class FireStoreDataSourceImpl implements FireStoreDataSource {

  final FirebaseFirestore _fireStore;
  FireStoreDataSourceImpl(this._fireStore);

  @override
  Future<List<Note>> getNotes() async {
    try {
      final querySnapshot = await _fireStore.collection('notes').get();
      return querySnapshot.docs
          .map((doc) => Note.fromJson(doc.data(), doc.reference.id))
          .toList();
    } catch (e) {
      throw Exception('Error getting notes: $e');
    }
  }

  @override
  Future<void> createNote(Note note) async {
    try {
      await _fireStore.collection('notes').doc().set(note.toJson());
    } catch (e) {
      throw Exception('Error creating note: $e');
    }
  }

  @override
  Future<void> updateNote(Note note) async {
    try {
      await _fireStore.collection('notes').doc(note.id.toString()).update(note.toJson());
    } catch (e) {
      throw Exception('Error updating note: $e');
    }
  }

  @override
  Future<void> deleteNote(String noteId) async {
    try {
      await _fireStore.collection('notes').doc(noteId).delete();
    } catch (e) {
      throw Exception('Error deleting note: $e');
    }
  }
}