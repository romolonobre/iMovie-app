import 'package:http/http.dart';
import 'package:imovie_app/app/_commons/app_services/error_handle.dart';

import '../../app_services/api_request.dart';
import '../../app_services/tmdb_api_response.dart';

class SearchDatasource extends APIRequest {
  Future<TMDBApiResponse> call(String value) async {
    Response? response;
    try {
      response = await this.get("3/search/movie?query=$value");
    } catch (e, s) {
      Errorhandler.report(e, s);
    } finally {
      return TMDBApiResponse(response);
    }
  }
}
