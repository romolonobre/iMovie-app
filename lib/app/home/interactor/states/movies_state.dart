import '../../../_commons/movie/entities/movie.dart';

abstract class MoviesState {}

class IdleState extends MoviesState {}

class MoviesLoadingState extends MoviesState {}

class MoviesLoadedState extends MoviesState {
  final List<Movie> movies;

  MoviesLoadedState({required this.movies});
}

class MoviesErrorState extends MoviesState {
  final String message;

  MoviesErrorState({required this.message});
}
