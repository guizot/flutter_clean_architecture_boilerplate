class FormItem {
  String id;
  String type;
  String typeName;
  String label;
  bool error;
  bool required;
  dynamic value;
  List<Map<String, dynamic>> content;

  FormItem({
    this.id = '',
    this.type = '',
    this.typeName = '',
    this.label = '',
    this.error = false,
    this.required = false,
    this.value,
    List<Map<String, dynamic>>? content,
  }): content = content ?? [];

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