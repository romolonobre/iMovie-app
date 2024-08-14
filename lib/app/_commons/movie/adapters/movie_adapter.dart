import 'package:imovie_app/app/_commons/app_services/entity_adaptor.dart';
import 'package:imovie_app/app/_commons/app_services/helper.dart';

import '../../app_services/utils.dart';
import '../entities/movie.dart';

class MovieAdapter implements EntityAdaptor<Movie> {
  @override
  Movie fromJson(json) {
    return Movie(
      id: Helper.getString(json["id"]),
      title: Helper.getString(json["original_title"]),
      description: Helper.getString(json["overview"]),
      postImage: imageBasePath + Helper.getString(json["poster_path"]),
      releaseDate: Helper.getString(json["release_date"]),
      voteAverage: Helper.getDouble(json["vote_average"]),
      backgroundImage: imageBasePath + Helper.getString(json["backdrop_path"]),
    );
  }

  @override
  List<Movie> fromJsonToList(json) {
    if (json == null) return [];
    List<Movie> movies = [];

    json['results'].forEach((e) {
      final Movie movie = MovieAdapter().fromJson(e);
      movies.add(movie);
    });
    return movies;
  }

  @override
  Map<String, dynamic> toMap(Movie value) => {};
}
