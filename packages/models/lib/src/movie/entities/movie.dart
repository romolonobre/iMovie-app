// ignore_for_file: public_member_api_docs, sort_constructors_first
class Movie {
  final String id;
  final String title;
  final String description;
  final String postImage;
  final String releaseDate;
  final double voteAverage;

  final String backgroundImage;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.postImage,
    required this.releaseDate,
    required this.voteAverage,
    required this.backgroundImage,
  });

  @override
  String toString() {
    return 'Movie(title: $title, description: $description, postImage: $postImage, releaseDate: $releaseDate, voteAverage: $voteAverage)';
  }
}
