import '../../interactor/states/movies_state.dart';

abstract class MoviesService {
  Future<MoviesState> getAll({required String endpoint});
}
