class ResponseWrapper<T> {
  int? totalCount;
  bool? incompleteResults;
  List<T>? items;

  ResponseWrapper({this.totalCount, this.incompleteResults, this.items});

  ResponseWrapper.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonItem) {
    totalCount = json['total_count'];
    incompleteResults = json['incomplete_results'];
    if (json['items'] != null) {
      items = <T>[];
      json['items'].forEach((v) {
        items!.add(fromJsonItem(v));
      });
    }
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonItem) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    data['incomplete_results'] = this.incompleteResults;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => toJsonItem(v)).toList();
    }
    return data;
  }
}