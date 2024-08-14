import 'entities/serie_details.dart';
import 'entities/series.dart';

abstract class SeriesState {}

class IdleState extends SeriesState {}

class SeriesLoadingState extends SeriesState {}

class SeriesLoadedState extends SeriesState {
  final List<Serie> series;

  SeriesLoadedState({required this.series});
}

class SeriesErrorState extends SeriesState {
  final String message;

  SeriesErrorState({required this.message});
}

class SerieDetailsLoadedState extends SeriesState {
  final SerieDetails details;

  SerieDetailsLoadedState({required this.details});
}
