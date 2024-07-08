class Note {
  String? id;
  String? title;
  String? description;

  Note({
    this.id,
    this.title,
    this.description,
  });

  Note.fromJson(Map<String, dynamic> json, String refId) {
    id = refId;
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}