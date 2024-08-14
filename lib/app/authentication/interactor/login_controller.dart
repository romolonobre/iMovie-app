// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../_commons/user/entities/app_user.dart';
import '../data/service/auth_service.dart';
import 'login_state.dart';

class LoginController {
  final AuthService service;
  LoginController(this.service);

  // This controller utilizes the State Pattern to return
  // the appropriate state based on the response from Firebase.

  Future<LoginState> login({required String email, required String password}) async {
    final result = await service.login(email, password);
    return result;
  }

  Future<LoginState> register({required String usrname, required String password}) async {
    final result = await service.register(usrname, password);
    return result;
  }

  Future<LoginState> signOut() async {
    final result = await service.signOut();
    return result;
  }

  Future<void> updateUsername(String name) async {
    await service.updateUsername(name);
  }

  Future<void> updateProfileImage(String image) async {
    await service.updateProfileImage(image);
  }

  AppUser? getUser() => service.getCurrentUser();

  Future<LoginState> signInWithGoogle() async {
    final result = await service.signInWithGoogle();
    return result;
  }

  bool isLogged() => service.getCurrentUser() != null;
}
