// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppUser {
  final String userId;
  final String email;
  final String name;
  final String imageUrl;
  bool isEmailVerifed;

  AppUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.imageUrl,
    this.isEmailVerifed = false,
  });

  @override
  String toString() {
    return 'AppUser(userId: $userId, email: $email, name: $name, imageUrl: $imageUrl, isEmailVerifed: $isEmailVerifed)';
  }
}
