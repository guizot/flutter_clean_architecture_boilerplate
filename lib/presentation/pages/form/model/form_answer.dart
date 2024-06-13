class FormAnswer {
  String id;
  dynamic answer;

  FormAnswer({required this.id, required this.answer});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'answer': answer,
    };
  }
}
