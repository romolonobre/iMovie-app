import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/movie_details/data/service/movie_details_service_impl.dart';

import 'data/datasource/movie_details_datasource.dart';
import 'data/datasource/movies_details_datasource_impl.dart';
import 'data/service/movie_details_service.dart';
import 'ui/movie_details_screen.dart';

class MovieDetailsModule extends Module {
  @override
  void binds(Injector i) {
    i.add<MovieDetailsDatasource>(MovieDetailsDatasourceImpl.new);
    i.add<MovieDetailsService>(MovieDetailsServiceImpl.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => MovieDetailsScreen(id: r.args.data));
  }
}
