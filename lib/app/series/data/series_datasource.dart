// ignore_for_file: control_flow_in_finally

import 'package:http/http.dart';
import 'package:imovie_app/app/_commons/app_services/api_request.dart';

import '../../_commons/app_services/error_handle.dart';
import '../../_commons/app_services/tmdb_api_response.dart';
import 'series_errors.dart';

class SeriesDatasource extends APIRequest {
  Future<TMDBApiResponse> getSeries() async {
    Response? response;
    try {
      response = await this.get("3/tv/on_the_air");
      return TMDBApiResponse(response);
    } catch (error, stackTrace) {
      Errorhandler.report(error, stackTrace, tag: "@SeriesDatasource getSeries");
      throw SeriesException(message: "Failed to get series: ${error.toString()}");
    }
  }

  Future<TMDBApiResponse> getDetails(String id) async {
    Response? response;
    try {
      response = await this.get("3/tv/$id");
      return TMDBApiResponse(response);
    } catch (error, stackTrace) {
      Errorhandler.report(error, stackTrace, tag: "@SeriesDatasource getDetails");
      throw SerieDetailsException(message: "Failed to get series details: ${error.toString()}");
    }
  }
}
