import 'package:flutter_test/flutter_test.dart';
import 'package:imovie_app/app/_commons/app_services/utils.dart';
import 'package:imovie_app/app/movie_details/data/adapters/reviews_adapter.dart';

void main() {
  group('ReviewsAdapter', () {
    test('fromJson returns a valid Review object', () {
      final json = {
        'author_details': {
          'username': 'Reviewer1',
          'avatar_path': '/avatar.jpg',
          'rating': 4.5,
        },
        'content': 'Great movie!',
        'created_at': '2023-07-17T12:34:56.000Z',
      };

      final review = ReviewsAdapter().fromJson(json);

      expect(review.name, 'Reviewer1');
      expect(review.content, 'Great movie!');
      expect(review.avatarUrl, '$Utils.imageBasePath/avatar.jpg');
      expect(review.rating, 4.5);
      expect(review.date, '2023-07-17T12:34:56.000Z');
    });

    test('fromJsonToList returns a list of Review objects', () {
      final json = {
        'results': [
          {
            'author_details': {
              'username': 'Reviewer1',
              'avatar_path': '/avatar1.jpg',
              'rating': 4.5,
            },
            'content': 'Great movie!',
            'created_at': '2023-07-17T12:34:56.000Z',
          },
          {
            'author_details': {
              'username': 'Reviewer2',
              'avatar_path': '/avatar2.jpg',
              'rating': 3.0,
            },
            'content': 'It was okay.',
            'created_at': '2023-07-16T11:22:33.000Z',
          },
        ]
      };

      final reviews = ReviewsAdapter().fromJsonToList(json);

      expect(reviews.length, 2);
      expect(reviews[0].name, 'Reviewer1');
      expect(reviews[0].content, 'Great movie!');
      expect(reviews[0].avatarUrl, '$Utils.imageBasePath/avatar1.jpg');
      expect(reviews[0].rating, 4.5);
      expect(reviews[0].date, '2023-07-17T12:34:56.000Z');
      expect(reviews[1].name, 'Reviewer2');
      expect(reviews[1].content, 'It was okay.');
      expect(reviews[1].avatarUrl, '$Utils.imageBasePath/avatar2.jpg');
      expect(reviews[1].rating, 3.0);
      expect(reviews[1].date, '2023-07-16T11:22:33.000Z');
    });

    test('fromJsonToList returns an empty list if json is null', () {
      final reviews = ReviewsAdapter().fromJsonToList(null);

      expect(reviews, isEmpty);
    });
  });
}
