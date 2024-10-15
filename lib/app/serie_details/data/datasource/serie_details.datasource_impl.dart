// ignore_for_file: control_flow_in_finally

import 'package:app_services/app_services.dart';

import '../serie_details_exceptions.dart';
import 'serie_details_datasource.dart';

class SerieDetailsDatasourceImpl extends APIRequest implements SerieDetailsDatasource {
  @override
  Future<TMDBApiResponse> getSeasons(String id, String seasonNumber) async {
    try {
      final response = await get("3/tv/$id/season/$seasonNumber");
      return TMDBApiResponse(response);
    } catch (error, stackTrace) {
      Errorhandler.report(error, stackTrace, tag: "@SerieDetailsDatasource getSeasons");
      throw SeasonsException(message: "Failed to get seasons: ${error.toString()}");
    }
  }

  @override
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
