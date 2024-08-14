import 'package:imovie_app/app/_commons/movie/entities/movie.dart';
import 'package:imovie_app/app/movie_details/interactor/entities/cast.dart';
import 'package:imovie_app/app/movie_details/interactor/entities/review.dart';

import '../../../movie_details/interactor/entities/genres.dart';

abstract class MovieDetailsState {}

class IdleState extends MovieDetailsState {}

class MoviesDetailsLoadingState extends MovieDetailsState {}

class MovieGenreLoadedState extends MovieDetailsState {
  final List<Genre> genre;

  MovieGenreLoadedState({required this.genre});
}

class MovieDetailsLoadedState extends MovieDetailsState {
  final Movie movie;

  MovieDetailsLoadedState({required this.movie});
}

class MovieCastLoadedState extends MovieDetailsState {
  final List<Cast> casts;

  MovieCastLoadedState({required this.casts});
}

class MovieVideosLoadedState extends MovieDetailsState {
  final List<String> videosId;

  MovieVideosLoadedState({required this.videosId});
}

class MoviePhotosLoadedState extends MovieDetailsState {
  final List<String> photosUrl;

  MoviePhotosLoadedState({required this.photosUrl});
}

class MovieReviewsLoadedState extends MovieDetailsState {
  final List<Review> reviews;

  MovieReviewsLoadedState({this.reviews = const []});
}

class MoviesDetailsErrorState extends MovieDetailsState {
  final String message;

  MoviesDetailsErrorState({required this.message});
}
