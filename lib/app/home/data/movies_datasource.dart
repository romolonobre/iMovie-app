// ignore_for_file: control_flow_in_finally

import 'package:http/http.dart';
import 'package:imovie_app/app/_commons/app_services/api_request.dart';

import '../../_commons/app_services/error_handle.dart';
import '../../_commons/app_services/tmdb_api_response.dart';

class MoviesDatasource extends APIRequest {
  Future<TMDBApiResponse> call({required String endpoint}) async {
    Response? response;
    try {
      response = await this.get(endpoint);
    } catch (error, stackTrace) {
      Errorhandler.report(error, stackTrace, tag: "MoviesDatasource call");
    } finally {
      return TMDBApiResponse(response);
    }
  }
}
