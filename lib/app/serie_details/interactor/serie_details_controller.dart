import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/service/serie_details_service.dart';
import 'serie_details_state.dart';

class SerieDetailsController extends StateNotifier<SerieDetailsState> {
  SerieDetailsService service;

  SerieDetailsController({required this.service}) : super(IdleState());

  // This controller uses the State Pattern to return the appropriate state
  // based on the API response. The result is obtained and emitted to the listenrs.

  Future getSeasons({required String id, required String seasonNumber}) async {
    state = SeriesDetailsLoadingState();
    final result = await service.getSeasons(id, seasonNumber);
    state = result;
  }

  Future getSeasonVideos({required String id, required String seasonNumber}) async {
    state = SeriesDetailsLoadingState();
    final result = await service.getSeasonVideos(id, seasonNumber);
    state = result;
  }
}
