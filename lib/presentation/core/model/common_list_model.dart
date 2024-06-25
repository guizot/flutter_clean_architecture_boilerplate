
class CommonListModel {
  String id;
  String title;
  String subtitle;
  Function tap;

  CommonListModel({
    this.id = "",
    required this.title,
    required this.subtitle,
    tap
  }): tap = tap ?? (() {});

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
    };
  }
}
