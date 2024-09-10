import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/datasource/serie_details.datasource_impl.dart';
import '../data/datasource/serie_details_datasource.dart';
import '../data/service/serie_details_service.dart';
import '../data/service/serie_details_service_impl.dart';
import '../interactor/serie_details_controller.dart';
import '../interactor/serie_details_state.dart';

// Provides the instance of the datasource to the provider tree
final serieDetailsDatasourceProvider = Provider<SerieDetailsDatasource>((ref) {
  return SerieDetailsDatasourceImpl();
});

// Provides the instance of the service to the provider tree, using the datasource
final serieDetailsServiceProvider = Provider<SerieDetailsService>((ref) {
  final datasource = ref.watch(serieDetailsDatasourceProvider);
  return SerieDetailsServiceImpl(datasource: datasource);
});

// We use a separate StateNotifier for seasons and season videos to avoid overwriting states
// StateNotifier for seasons
final seasonsNotifierProvider = StateNotifierProvider<SerieDetailsController, SerieDetailsState>((ref) {
  final service = ref.watch(serieDetailsServiceProvider);
  return SerieDetailsController(service: service);
});

// StateNotifier for season videos
final seasonVideosNotifierProvider = StateNotifierProvider<SerieDetailsController, SerieDetailsState>((ref) {
  final service = ref.watch(serieDetailsServiceProvider);
  return SerieDetailsController(service: service);
});
