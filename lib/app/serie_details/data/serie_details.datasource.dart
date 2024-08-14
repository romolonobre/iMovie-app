// ignore_for_file: control_flow_in_finally

import '../../_commons/app_services/api_request.dart';
import '../../_commons/app_services/error_handle.dart';
import '../../_commons/app_services/tmdb_api_response.dart';
import 'serie_details_exceptions.dart';

class SerieDetailsDatasource extends APIRequest {
  Future<TMDBApiResponse> getSeasons(String id, String seasonNumber) async {
    try {
      final response = await get("3/tv/$id/season/$seasonNumber");
      return TMDBApiResponse(response);
    } catch (error, stackTrace) {
      Errorhandler.report(error, stackTrace, tag: "@SerieDetailsDatasource getSeasons");
      throw SeasonsException(message: "Failed to get seasons: ${error.toString()}");
    }
  }

  Future<TMDBApiResponse> getSeasonVideos(String id, String seasonNumber) async {
    try {
      final response = await get("3/tv/$id/season/$seasonNumber/videos");
      return TMDBApiResponse(response);
    } catch (error, stackTrace) {
      Errorhandler.report(error, stackTrace, tag: "@SerieDetailsDatasource getSeasonVideos");
      throw SeasonVideosException(message: "Failed to get season videos: ${error.toString()}");
    }
  }
}
