import '../../interactor/states/movie_details_state.dart';

abstract class MovieDetailsService {
  Future<MovieDetailsState> getDetails({required String id});
  Future<MovieDetailsState> getGenres({required String id});
  Future<MovieDetailsState> getCast({required String id});
  Future<MovieDetailsState> getVideos({required String id});
  Future<MovieDetailsState> getPhotos({required String id});
  Future<MovieDetailsState> getReviews({required String id});
}
