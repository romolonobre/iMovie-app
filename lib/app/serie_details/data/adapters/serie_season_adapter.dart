import '../../../_commons/app_services/entity_adaptor.dart';
import '../../../_commons/app_services/helper.dart';
import '../../../_commons/app_services/utils.dart';
import '../../interactor/entities/serie_season.dart';

class SerieSeasonAdapter extends EntityAdaptor<SerieSeason> {
  @override
  SerieSeason fromJson(json) {
    return SerieSeason(
      airDate: Helper.getString(json["air_date"]),
      name: Helper.getString(json["name"]),
      description: Helper.getString(json["overview"]),
      postImage: imageBasePath + Helper.getString(json["still_path"]),
      voteAverage: Helper.getDouble(json["vote_average"]),
      seasonNumber: Helper.getInt(json["season_number"]),
      episodeCount: Helper.getInt(json["episode_count"]),
      episodeNumber: Helper.getInt(json["episode_number"]),
      runTime: Helper.getInt(json["runtime"]),
    );
  }

  @override
  List<SerieSeason> fromJsonToList(json) {
    if (json == null) return [];
    List<SerieSeason> seasons = [];

    json['seasons'].forEach((e) {
      final SerieSeason season = SerieSeasonAdapter().fromJson(e);
      seasons.add(season);
    });
    return seasons;
  }

  @override
  Map<String, dynamic> toMap(SerieSeason value) => {};
}
