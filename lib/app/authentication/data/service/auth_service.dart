import '../../../_commons/user/entities/app_user.dart';
import '../../interactor/login_state.dart';

// AuthService interface to keep authentication logic flexible and
// not tied to a specific implementation eg:firebase
abstract class AuthService {
  Future<LoginState> login(String email, String password);
  Future<LoginState> register(String email, String password);
  Future<void> updateUsername(String name);
  Future<void> updateProfileImage(String image);
  AppUser? getCurrentUser();
  Future<void> sendEmailVerification();
  Future<LoginState> signInWithGoogle();
  Future<LoginState> signOut();
}
