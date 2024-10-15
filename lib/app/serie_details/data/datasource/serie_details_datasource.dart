import 'package:app_services/app_services.dart';

abstract class SerieDetailsDatasource {
  Future<TMDBApiResponse> getSeasons(String id, String seasonNumber);
  Future<TMDBApiResponse> getSeasonVideos(String id, String seasonNumber);
}
