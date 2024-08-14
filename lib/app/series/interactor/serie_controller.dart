import 'package:flutter/material.dart';

import '../data/series_service.dart';
import 'series_states.dart';

class SerieController extends ValueNotifier<SeriesState> {
  final SeriesService service;
  SerieController(this.service) : super(IdleState());

  // This controller uses the State Pattern to return the appropriate state
  // based on the API response

  Future getSeries() async {
    _emit(SeriesLoadingState());
    final result = await service.getSeries();
    _emit(result);
  }

  Future getDetails(String id) async {
    _emit(SeriesLoadingState());
    final result = await service.getDetails(id);
    _emit(result);
  }

  void _emit(SeriesState state) => value = state;
}
