import 'package:flutter_test/flutter_test.dart';
import 'package:imovie_app/app/_commons/movie/adapters/movie_adapter.dart';

void main() {
  group('MovieAdapter', () {
    final movieJson = {
      "id": "1",
      "original_title": "Test Movie",
      "overview": "This is a test movie.",
      "poster_path": "/test.jpg",
      "release_date": "2023-01-01",
      "vote_average": 8.5
    };

    final invalidJson = {
      "id": 2,
      "original_title": null,
      "overview": 3.3,
      "poster_path": "/test.jpg",
      "release_date": "2023-01-01",
      "vote_average": 8.5
    };

    final movieListJson = {
      "results": [
        {
          "id": "1",
          "original_title": "Test Movie 1",
          "overview": "This is the first test movie.",
          "poster_path": "/test1.jpg",
          "release_date": "2023-01-01",
          "vote_average": 8.5
        },
        {
          "id": "2",
          "original_title": "Test Movie 2",
          "overview": "This is the second test movie.",
          "poster_path": "/test2.jpg",
          "release_date": "2023-02-01",
          "vote_average": 7.5
        }
      ]
    };

    test('fromJson should return a Movie ', () {
      final movie = MovieAdapter().fromJson(movieJson);

      expect(movie.id, "1");
      expect(movie.title, "Test Movie");
      expect(movie.description, "This is a test movie.");
      expect(movie.postImage, "https://image.tmdb.org/t/p/w200/test.jpg");
      expect(movie.releaseDate, "2023-01-01");
      expect(movie.voteAverage, 8.5);
    });

    test('fromJsonToList should return a list of Movies', () {
      final movies = MovieAdapter().fromJsonToList(movieListJson);

      expect(movies.length, 2);
      expect(movies[0].id, "1");
      expect(movies[0].title, "Test Movie 1");
      expect(movies[0].description, "This is the first test movie.");
      expect(movies[0].postImage, "https://image.tmdb.org/t/p/w200/test1.jpg");
      expect(movies[0].releaseDate, "2023-01-01");
      expect(movies[0].voteAverage, 8.5);

      expect(movies[1].id, "2");
      expect(movies[1].title, "Test Movie 2");
      expect(movies[1].description, "This is the second test movie.");
      expect(movies[1].postImage, "https://image.tmdb.org/t/p/w200/test2.jpg");
      expect(movies[1].releaseDate, "2023-02-01");
      expect(movies[1].voteAverage, 7.5);
    });

    test('fromJson should not break if there is any invalid data types', () {
      final movie = MovieAdapter().fromJson(invalidJson);

      expect(movie.id, "2");
      expect(movie.title, "");
      expect(movie.description, "3.3");
      expect(movie.postImage, "https://image.tmdb.org/t/p/w200/test.jpg");
      expect(movie.releaseDate, "2023-01-01");
      expect(movie.voteAverage, 8.5);
    });

    test('fromJsonToList should return an empty list if json is null or not a list', () {
      final movies = MovieAdapter().fromJsonToList([]);
      expect(movies, isEmpty);

      final moviesFromInvalidJson = MovieAdapter().fromJsonToList(null);
      expect(moviesFromInvalidJson, isEmpty);
    });
  });
}
