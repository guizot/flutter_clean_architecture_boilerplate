import '../../data/core/constant/const_values.dart';

class MovieTMDB {
  int? id;
  String? title;
  String? overview;
  String? posterPath;

  MovieTMDB({
    this.id,
    this.title,
    this.overview,
    this.posterPath
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['id'] = id;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    return data;
  }

  String getPoster() {
    return '${ConstValues.tmdbImageUrl}/w200$posterPath';
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
    };
  }

}