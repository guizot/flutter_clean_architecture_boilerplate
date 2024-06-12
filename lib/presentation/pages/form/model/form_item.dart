class FormItem {
  final String id;
  final String type;
  final String typeName;
  final String label;
  bool error = false;
  bool required = false;
  dynamic value;

  FormItem({
    required this.id,
    required this.type,
    required this.typeName,
    required this.label,
    required this.error,
    required this.required,
    this.value
  });
}
