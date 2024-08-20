// ignore_for_file: control_flow_in_finally

import 'package:imovie_app/app/_commons/app_services/api_request.dart';

import '../../../_commons/app_services/error_handle.dart';
import '../../../_commons/app_services/tmdb_api_response.dart';
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
