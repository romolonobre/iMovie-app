import 'package:app_services/app_services.dart';

abstract class MovieDetailsDatasource {
  Future<TMDBApiResponse> getGenres({required String id});
  Future<TMDBApiResponse> getDetails({required String id});
  Future<TMDBApiResponse> getCast({required String id});
  Future<TMDBApiResponse> getVideos({required String id});
  Future<TMDBApiResponse> getPhotos({required String id});
  Future<TMDBApiResponse> getReviews({required String id});
}
