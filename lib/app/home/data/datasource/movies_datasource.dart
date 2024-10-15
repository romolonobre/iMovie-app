import 'package:app_services/app_services.dart';

abstract class MoviesDatasource {
  Future<TMDBApiResponse> call({required String endpoint});
}
