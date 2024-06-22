import 'package:flutter_clean_architecture/presentation/pages/form/model/form_content.dart';

class FormItem {
  String id;
  String type;
  String typeName;
  String label;
  bool error;
  bool required;
  bool disabled;
  dynamic value;
  List<FormContent> content;

  FormItem({
    this.id = '',
    this.type = '',
    this.typeName = '',
    this.label = '',
    this.error = false,
    this.required = false,
    this.disabled = false,
    this.value,
    List<FormContent>? content,
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