import 'package:app_services/app_services.dart';
import 'package:http/http.dart';

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
