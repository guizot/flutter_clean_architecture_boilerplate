class FormItem {
  final String id;
  final String type;
  final String typeName;
  final String label;
  bool error;
  bool required;
  dynamic value;
  List<Map<String, dynamic>> content;

  FormItem({
    required this.id,
    required this.type,
    required this.typeName,
    required this.label,
    this.error = false,
    this.required = false,
    this.value,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'typeName': typeName,
      'label': label,
      'error': error,
      'required': required,
      'value': value,
      'content': content,
    };
  }
}