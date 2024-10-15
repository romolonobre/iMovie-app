// ignore_for_file: control_flow_in_finally

import 'package:app_services/app_services.dart';
import 'package:http/http.dart';

import '../series_errors.dart';
import 'series_datasource.dart';

class SeriesDatasourceImpl extends APIRequest implements SeriesDatasource {
  @override
  Future<TMDBApiResponse> getSeries() async {
    Response? response;
    try {
      response = await this.get("3/tv/on_the_air");
      return TMDBApiResponse(response);
    } catch (error, stackTrace) {
      Errorhandler.report(error, stackTrace, tag: "@SeriesDatasourceImpl getSeries");
      throw SeriesException(message: "Failed to get series: ${error.toString()}");
    }
  }

  @override
  Future<TMDBApiResponse> getDetails(String id) async {
    Response? response;
    try {
      response = await this.get("3/tv/$id");
      return TMDBApiResponse(response);
    } catch (error, stackTrace) {
      Errorhandler.report(error, stackTrace, tag: "@SeriesDatasourceImpl getDetails");
      throw SeriesException(message: "Failed to get series details: ${error.toString()}");
    }
  }
}
