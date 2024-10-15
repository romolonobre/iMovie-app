// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_services/app_services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../authentication/interactor/login_controller.dart';

class VerifyUserStatus {
  final LoginController controller;

  VerifyUserStatus({required this.controller}) {
    bool isLogged = controller.isLogged();
    final String navigatoPath = isLogged ? "home" : "login";
    bool isBiometricsAuthEnabled = Cache().isBiometricsEnabled() ?? false;

    if (!isLogged) {
      Modular.to.navigate('/login/');
    } else if (!isBiometricsAuthEnabled) {
      Future.delayed(const Duration(seconds: 2)).then((_) => Modular.to.navigate('/$navigatoPath/'));
    } else {
      Modular.to.navigate('/biometrics/');
    }
  }
}
