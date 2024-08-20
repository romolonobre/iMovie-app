import '../../interactor/series_states.dart';

abstract class SeriesService {
  Future<SeriesState> getSeries();
  Future<SeriesState> getDetails(String id);
}
