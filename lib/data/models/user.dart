class User {
  int? id;
  String? login;
  String? avatar_url;
  String? html_url;

  User({this.id, this.login, this.avatar_url, this.html_url});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    avatar_url = json['avatar_url'];
    html_url = json['html_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['login'] = login;
    data['avatar_url'] = avatar_url;
    data['html_url'] = html_url;
    return data;
  }
}
