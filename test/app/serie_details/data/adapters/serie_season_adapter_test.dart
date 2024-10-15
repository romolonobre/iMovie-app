import 'package:flutter_test/flutter_test.dart';
import 'package:imovie_app/app/_commons/app_services/utils.dart';
import 'package:imovie_app/app/serie_details/data/adapters/serie_season_adapter.dart';

void main() {
  group('SerieSeasonAdapter', () {
    final json = {
      "air_date": "2023-07-17",
      "name": "Season 1",
      "overview": "This is the first season.",
      "still_path": "/image.jpg",
      "vote_average": 8.5,
      "season_number": 1,
      "episode_count": 10,
      "episode_number": 1,
      "runtime": 60
    };

    final jsonList = {
      "seasons": [
        {
          "air_date": "2023-07-17",
          "name": "Season 1",
          "overview": "This is the first season.",
          "still_path": "/image1.jpg",
          "vote_average": 8.5,
          "season_number": 1,
          "episode_count": 10,
          "episode_number": 1,
          "runtime": 60
        },
        {
          "air_date": "2024-07-17",
          "name": "Season 2",
          "overview": "This is the second season.",
          "still_path": "/image2.jpg",
          "vote_average": 9.0,
          "season_number": 2,
          "episode_count": 12,
          "episode_number": 2,
          "runtime": 70
        }
      ]
    };

    final invalidJson = {
      "air_date": 12345,
      "name": 6789.0,
      "overview": [],
      "still_path": null,
      "vote_average": "2.4",
      "season_number": "2",
      "episode_count": null,
      "episode_number": [],
      "runtime": {}
    };

    test('fromJson returns a valid SerieSeason object', () {
      final adapter = SerieSeasonAdapter();

      final season = adapter.fromJson(json);

      expect(season.airDate, '2023-07-17');
      expect(season.name, 'Season 1');
      expect(season.description, 'This is the first season.');
      expect(season.postImage, '$Utils.imageBasePath/image.jpg');
      expect(season.voteAverage, 8.5);
      expect(season.seasonNumber, 1);
      expect(season.episodeCount, 10);
      expect(season.episodeNumber, 1);
      expect(season.runTime, 60);
    });

    test('fromJsonToList returns a list of SerieSeason objects', () {
      final adapter = SerieSeasonAdapter();

      final seasons = adapter.fromJsonToList(jsonList);

      expect(seasons.length, 2);
      expect(seasons[0].airDate, '2023-07-17');
      expect(seasons[0].name, 'Season 1');
      expect(seasons[0].description, 'This is the first season.');
      expect(seasons[0].postImage, '$Utils.imageBasePath/image1.jpg');
      expect(seasons[0].voteAverage, 8.5);
      expect(seasons[0].seasonNumber, 1);
      expect(seasons[0].episodeCount, 10);
      expect(seasons[0].episodeNumber, 1);

      expect(seasons[0].runTime, 60);
      expect(seasons[1].airDate, '2024-07-17');
      expect(seasons[1].name, 'Season 2');
      expect(seasons[1].description, 'This is the second season.');
      expect(seasons[1].postImage, '$Utils.imageBasePath/image2.jpg');
      expect(seasons[1].voteAverage, 9.0);
      expect(seasons[1].seasonNumber, 2);
      expect(seasons[1].episodeCount, 12);
      expect(seasons[1].episodeNumber, 2);
      expect(seasons[1].runTime, 70);
    });

    test('fromJsonToList returns an empty list if json is null', () {
      final adapter = SerieSeasonAdapter();
      final seasons = adapter.fromJsonToList(null);

      expect(seasons, isEmpty);
    });

    test('fromJson handles invalid data types gracefully', () {
      final adapter = SerieSeasonAdapter();

      final season = adapter.fromJson(invalidJson);

      // The Helper methods should handle invalid types and return default values.
      expect(season.airDate, '12345');
      expect(season.name, '6789.0');
      expect(season.description, '');
      expect(season.postImage, Utils.imageBasePath);
      expect(season.voteAverage, 2.4);
      expect(season.seasonNumber, 2);
      expect(season.episodeCount, 0);
      expect(season.episodeNumber, 0);
      expect(season.runTime, 0);
    });
  });
}
