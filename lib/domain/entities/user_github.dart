import 'package:hive/hive.dart';
part 'user_github.g.dart';

@HiveType(typeId: 1)
class UserGithub {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? login;
  @HiveField(2)
  String? avatarUrl;
  @HiveField(3)
  String? htmlUrl;

  UserGithub({
    this.id,
    this.login,
    this.avatarUrl,
    this.htmlUrl
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['login'] = login;
    data['id'] = id;
    data['avatar_url'] = avatarUrl;
    data['html_url'] = htmlUrl;
    return data;
  }

}