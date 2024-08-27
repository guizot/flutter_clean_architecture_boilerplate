import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/data/models/note.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../models/note_response.dart';
import 'graphql_data_source.dart';

class GraphQLDataSourceImpl implements GraphQLDataSource {

  final GraphQLClient _client;
  GraphQLDataSourceImpl(this._client);

  @override
  Future<List<NoteModel>> getNotes() async {
    final querySnapshot = await _client.query(
        QueryOptions(
            document: gql(
            '''
            query Notes {
                notes {
                    data {
                        id
                        attributes {
                            title
                            description
                            createdAt
                            updatedAt
                        }
                    }
                }
            }
            '''
          ),
          fetchPolicy: FetchPolicy.networkOnly
        )
    );
    if (querySnapshot.hasException) {
      throw Exception('Error getting notes: ${querySnapshot.exception.toString()}');
    }
    if (querySnapshot.data != null) {
      final notesResponse = NotesResponse.fromJson(querySnapshot.data!['notes']);
      return notesResponse.notes;
    }
    return [];
  }

  @override
  Future<void> createNote(Note note) async {
    final querySnapshot = await _client.mutate(
        MutationOptions(
          document: gql(
            '''
            mutation CreateNote(\$title: String!, \$description: String!) {
                createNote(data: { title: \$title, description: \$description }) {
                    data {
                        id
                        attributes {
                            title
                            description
                            createdAt
                            updatedAt
                        }
                    }
                }
            }
            '''
          ),
          variables: { 'title': note.title, 'description': note.description }
        )
    );
    if (querySnapshot.hasException) {
      throw Exception('Error create note: ${querySnapshot.exception.toString()}');
    }
  }

  @override
  Future<void> updateNote(Note note) async {
    final querySnapshot = await _client.mutate(
        MutationOptions(
          document: gql(
          '''
          mutation UpdateNote(\$id: ID!, \$title: String!, \$description: String!) {
              updateNote(id: \$id, data: { title: \$title, description: \$description }) {
                  data {
                      id
                      attributes {
                          title
                          description
                          createdAt
                          updatedAt
                      }
                  }
              }
          }
          '''
          ),
          variables: { 'id': note.id, 'title': note.title, 'description': note.description }
        )
    );
    if (querySnapshot.hasException) {
      throw Exception('Error update note: ${querySnapshot.exception.toString()}');
    }
  }

  @override
  Future<void> deleteNote(String noteId) async {
    final querySnapshot = await _client.mutate(
      MutationOptions(
        document: gql(
          '''
          mutation DeleteNote(\$id: ID!) {
              deleteNote(id: \$id) {
                  data {
                      id
                      attributes {
                          title
                          description
                          createdAt
                          updatedAt
                      }
                  }
              }
          }
          '''
        ),
        variables: { 'id': noteId }
      )
    );
    if (querySnapshot.hasException) {
      throw Exception('Error delete note: ${querySnapshot.exception.toString()}');
    }
  }
}