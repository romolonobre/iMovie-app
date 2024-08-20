import '../../../_commons/app_services/tmdb_api_response.dart';

abstract class SerieDetailsDatasource {
  Future<TMDBApiResponse> getSeasons(String id, String seasonNumber);
  Future<TMDBApiResponse> getSeasonVideos(String id, String seasonNumber);
}
