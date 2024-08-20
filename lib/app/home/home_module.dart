import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/home/data/datasource/movies_datasource_impl.dart';
import 'package:imovie_app/app/home/data/service/movies_service_impl.dart';

import '../movie_details/movie_details_module.dart';
import '../serie_details/serie_details_module.dart';
import 'data/datasource/movies_datasource.dart';
import 'data/service/movies_service.dart';
import 'ui/navigation_bar_config.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.add<MoviesDatasource>(MoviesDatasourceImpl.new);
    i.add<MoviesService>(MoviesServiceImpl.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const NavigationBarConfig());
    r.module('/details', module: MovieDetailsModule());
    r.module('/serie-details', module: SerieDetailsModule());
  }
}
