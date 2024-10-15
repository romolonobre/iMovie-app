import 'package:app_services/app_services.dart';
import 'package:imovie_app/app/serie_details/data/service/serie_details_service.dart';

import '../../interactor/entities/serie_season.dart';
import '../../interactor/entities/serie_video.dart';
import '../../interactor/serie_details_state.dart';
import '../adapters/serie_season_adapter.dart';
import '../datasource/serie_details_datasource.dart';

class SerieDetailsServiceImpl implements SerieDetailsService {
  final SerieDetailsDatasource datasource;

  SerieDetailsServiceImpl({required this.datasource});
  @override
  Future<SerieDetailsState> getSeasons(String id, String seasonNumber) async {
    try {
      final response = await datasource.getSeasons(id, seasonNumber);

      List<SerieSeason> seasons = [];
      if (response.hasError) {
        return SeriesDetailsErrorState(message: response.errorMessage);
      }

      // We cant use SerieSeasonAdapter.fromJsonToList because the attribute
      // changes to "episodes", so we parse the list here
      response.data['episodes'].forEach((e) {
        final SerieSeason season = SerieSeasonAdapter().fromJson(e);
        seasons.add(season);
      });

      return SerieSeasonLoadedState(seasons: seasons);
    } catch (e) {
      return SeriesDetailsErrorState(message: e.toString());
    }
  }

  @override
  Future<SerieDetailsState> getSeasonVideos(String id, String seasonNumber) async {
    try {
      final response = await datasource.getSeasonVideos(id, seasonNumber);

      List<SerieVideo> vidoes = [];

      if (response.hasError) {
        return SeriesDetailsErrorState(message: response.errorMessage);
      }

      response.data['results'].forEach((e) {
        final SerieVideo season = SerieVideo(
          id: Helper.getString(e['key']),
          name: Helper.getString(e['name']),
        );
        vidoes.add(season);
      });

      if (vidoes.isEmpty) {
        return SerieSeasonVideosEmptyState(videos: []);
      }

      return SerieSeasonVideosLoadedState(videos: vidoes);
    } catch (e) {
      return SeriesDetailsErrorState(message: e.toString());
    }
  }
}
