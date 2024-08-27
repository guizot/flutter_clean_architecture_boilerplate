class NoteModel {
  final String id;
  final NoteAttributes attributes;

  NoteModel({required this.id, required this.attributes});

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as String,
      attributes: NoteAttributes.fromJson(json['attributes']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'attributes': attributes.toMap(),
    };
  }
}

class NoteAttributes {
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  NoteAttributes({
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NoteAttributes.fromJson(Map<String, dynamic> json) {
    return NoteAttributes(
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class NotesResponse {
  final List<NoteModel> notes;

  NotesResponse({required this.notes});

  factory NotesResponse.fromJson(Map<String, dynamic> json) {
    var data = json['data'] as List;
    List<NoteModel> notes = data.map((note) => NoteModel.fromJson(note)).toList();

    return NotesResponse(notes: notes);
  }

  Map<String, dynamic> toMap() {
    return {
      'data': notes.map((note) => note.toMap()).toList(),
    };
  }
}