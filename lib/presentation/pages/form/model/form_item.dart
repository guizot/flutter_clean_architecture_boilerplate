class FormItem {
  final String id;
  final String type;
  final String typeName;
  final String label;
  dynamic value;

  FormItem({
    required this.id,
    required this.type,
    required this.typeName,
    required this.label,
    this.value
  });
}
