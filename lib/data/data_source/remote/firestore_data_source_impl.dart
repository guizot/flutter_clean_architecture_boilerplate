import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_clean_architecture/data/data_source/remote/firestore_data_source.dart';
import 'package:flutter_clean_architecture/data/models/note.dart';

class FireStoreDataSourceImpl implements FireStoreDataSource {

  final FirebaseFirestore _fireStore;
  FireStoreDataSourceImpl(this._fireStore);

  @override
  Future<void> createNote(Note note) async {
    try {
      await _fireStore.collection('notes').doc(note.id as String?).set(note.toJson());
    } catch (e) {
      throw Exception('Error creating note: $e');
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

  @override
  Future<List<Note>> getNotes() async {
    try {
      final querySnapshot = await _fireStore.collection('notes').get();
      return querySnapshot.docs
          .map((doc) => Note.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error getting notes: $e');
    }
  }

  @override
  Future<void> updateNote(Note note) async {
    try {
      await _fireStore.collection('notes').doc(note.id as String?).update(note.toJson());
    } catch (e) {
      throw Exception('Error updating note: $e');
    }
  }
}