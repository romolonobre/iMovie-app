// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:models/models.dart';

import '../../interactor/states/movies_state.dart';
import '../datasource/movies_datasource.dart';
import 'movies_service.dart';

class MoviesServiceImpl implements MoviesService {
  MoviesDatasource datasource;
  MoviesServiceImpl({required this.datasource});

  @override
  Future<MoviesState> getAll({required String endpoint}) async {
    try {
      final response = await datasource(endpoint: endpoint);

      if (response.hasError) {
        return MoviesErrorState(message: response.errorMessage);
      }

      List<Movie> movies = MovieAdapter().fromJsonToList(response.data);
      return MoviesLoadedState(movies: movies);
    } catch (e) {
      return MoviesErrorState(message: e.toString());
    }
  }
}
