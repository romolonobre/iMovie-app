// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../movie_details/interactor/entities/genres.dart';
import '../../../serie_details/interactor/entities/serie_season.dart';

class SerieDetails {
  final String releaseDate;
  final double vote;
  final String postImage;
  final String homePageLink;
  final List<SerieSeason> seasons;
  final List<Genre> genres;

  SerieDetails(
      {required this.releaseDate,
      required this.vote,
      required this.postImage,
      required this.homePageLink,
      required this.seasons,
      required this.genres});

  @override
  String toString() {
    return 'SerieDetails(releaseDate: $releaseDate, vote: $vote, postImage: $postImage, homePageLink: $homePageLink, seasons: $seasons, genres: $genres)';
  }
}
