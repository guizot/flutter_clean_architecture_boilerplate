class FormContent {
  String? id;
  dynamic value;
  String label;

  FormContent({this.id, required this.value, required this.label});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'label': label,
    };
  }
}
