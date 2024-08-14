import 'package:flutter_test/flutter_test.dart';
import 'package:imovie_app/app/_commons/app_services/utils.dart';
import 'package:imovie_app/app/movie_details/data/adapters/cast_adpater.dart';

void main() {
  group('CastAdapter', () {
    final json = {
      'name': 'Actor Name',
      'character': 'Character Name',
      'profile_path': '/profile.jpg',
    };

    final jsonList = {
      'cast': [
        {
          'name': 'Actor Name 1',
          'character': 'Character Name 1',
          'profile_path': '/profile1.jpg',
        },
        {
          'name': 'Actor Name 2',
          'character': 'Character Name 2',
          'profile_path': '/profile2.jpg',
        },
      ]
    };

    final invalidJson = {
      'name': 2,
      'character': 2.4,
      'profile_path': '/profile.jpg',
    };
    test('fromJson returns a valid Cast', () {
      final cast = CastAdapter().fromJson(json);

      expect(cast.name, 'Actor Name');
      expect(cast.character, 'Character Name');
      expect(cast.image, '$imageBasePath/profile.jpg');
    });

    test('fromJsonToList returns a list of Cast', () {
      final casts = CastAdapter().fromJsonToList(jsonList);

      expect(casts.length, 2);
      expect(casts[0].name, 'Actor Name 1');
      expect(casts[0].character, 'Character Name 1');
      expect(casts[0].image, '$imageBasePath/profile1.jpg');
      expect(casts[1].name, 'Actor Name 2');
      expect(casts[1].character, 'Character Name 2');
      expect(casts[1].image, '$imageBasePath/profile2.jpg');
    });
    test('fromJson should not break if there is any invalid data types', () {
      final cast = CastAdapter().fromJson(invalidJson);
      expect(cast.name, "2");
      expect(cast.character, "2.4");
      expect(cast.image, '$imageBasePath/profile.jpg');
    });

    test('fromJsonToList returns an empty list if json is null', () {
      final casts = CastAdapter().fromJsonToList(null);

      expect(casts, isEmpty);
    });
  });
}
