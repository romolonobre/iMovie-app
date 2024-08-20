import '../../../_commons/app_services/tmdb_api_response.dart';

abstract class MoviesDatasource {
  Future<TMDBApiResponse> call({required String endpoint});
}
