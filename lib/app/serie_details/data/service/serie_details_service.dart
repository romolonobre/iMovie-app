import '../../interactor/serie_details_state.dart';

abstract class SerieDetailsService {
  Future<SerieDetailsState> getSeasons(String id, String seasonNumber);
  Future<SerieDetailsState> getSeasonVideos(String id, String seasonNumber);
}
