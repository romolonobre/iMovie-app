import '../../../_commons/app_services/tmdb_api_response.dart';

abstract class SeriesDatasource {
  Future<TMDBApiResponse> getSeries();
  Future<TMDBApiResponse> getDetails(String id);
}
