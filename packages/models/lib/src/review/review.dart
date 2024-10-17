// ignore_for_file: public_member_api_docs, sort_constructors_first
class Review {
  final String name;
  final String content;
  final String avatarUrl;
  final double rating;
  final String date;

  Review({
    required this.name,
    required this.content,
    required this.avatarUrl,
    required this.rating,
    required this.date,
  });

  @override
  String toString() {
    return 'Reviews(name: $name, content: $content, avatarUrl: $avatarUrl, rating: $rating, date: $date)';
  }
}
