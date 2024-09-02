import 'package:flutter_modular/flutter_modular.dart';

import '_commons/flutter_widgets/search/search_controller.dart';
import '_commons/flutter_widgets/search/search_datasource.dart';
import '_commons/flutter_widgets/search/search_service.dart';
import 'authentication/data/service/auth_service.dart';
import 'authentication/data/service/firebase_auth_service.dart';
import 'authentication/interactor/login_controller.dart';
import 'authentication/login_module.dart';
import 'biometric/biometric_auth_screen.dart';
import 'home/home_module.dart';
import 'series/data/datasource/series_datasource.dart';
import 'series/data/datasource/series_datasource_impl.dart';
import 'series/data/service/series_service.dart';
import 'series/data/service/series_service_impl.dart';
import 'series/interactor/serie_controller.dart';
import 'spash_screen.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.add<SeriesDatasource>(SeriesDatasourceImpl.new);
    i.add<SeriesService>(SeriesServiceImpl.new);
    i.add(SerieController.new);

    // Auth
    i.add<AuthService>(FirebaseAuthService.new);
    i.add(LoginController.new);

    // Search
    i.add(SearchDatasource.new);
    i.add(SearchService.new);
    i.add(CustomSearchController.new);
  }

  @override
  void routes(r) {
    r.child("/splashscreen/", child: (context) => const SplashScreen());
    r.child("/biometrics/", child: (context) => BiometricAuthScreen(naviagtionPath: r.args.data));
    r.module('/home', module: HomeModule());
    r.module('/login', module: LoginModule());
  }
}
