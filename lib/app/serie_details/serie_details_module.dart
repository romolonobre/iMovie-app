import 'package:flutter_modular/flutter_modular.dart';

import 'data/datasource/serie_details.datasource_impl.dart';
import 'data/datasource/serie_details_datasource.dart';
import 'data/service/serie_details_service.dart';
import 'data/service/serie_details_service_impl.dart';
import 'interactor/serie_details_controller.dart';
import 'ui/serie_details_screen.dart';

class SerieDetailsModule extends Module {
  @override
  void binds(i) {
    i.add<SerieDetailsDatasource>(SerieDetailsDatasourceImpl.new);
    i.add<SerieDetailsService>(SerieDetailsServiceImpl.new);

    i.add(SerieDetailsController.new);
  }

  @override
  void routes(r) {
    r.child("/", child: (context) => SerieDetailsScreen(serie: r.args.data));
  }
}
