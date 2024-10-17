// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';

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

  // Static method to get current user directly from Firebase
  static AppUser? getCurrentUser() {
    final user = FirebaseAuth.instance.currentUser;
    return user != null
        ? AppUser(
            userId: user.uid,
            email: user.email ?? '',
            name: user.displayName ?? '',
            imageUrl: user.photoURL ?? '',
            isEmailVerifed: user.emailVerified,
          )
        : null;
  }

  @override
  String toString() {
    return 'AppUser(userId: $userId, email: $email, name: $name, imageUrl: $imageUrl, isEmailVerifed: $isEmailVerifed)';
  }
}
