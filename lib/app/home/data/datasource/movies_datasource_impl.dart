import 'package:app_services/app_services.dart';

import '../movies_exception.dart';
import 'movies_datasource.dart';

class MoviesDatasourceImpl extends APIRequest implements MoviesDatasource {
  @override
  Future<TMDBApiResponse> call({required String endpoint}) async {
    try {
      final response = await get(endpoint);
      return TMDBApiResponse(response);
    } catch (error, stackTrace) {
      Errorhandler.report(error, stackTrace, tag: "MoviesDatasourceImpl call");
      throw MoviesException(message: "Failed to get movies from $endpoint: ${error.toString()}");
    }
  }
}
