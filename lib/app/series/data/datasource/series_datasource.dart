import 'package:app_services/app_services.dart';

abstract class SeriesDatasource {
  Future<TMDBApiResponse> getSeries();
  Future<TMDBApiResponse> getDetails(String id);
}
