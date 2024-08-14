import 'seach_result.dart';

sealed class SearchState {}

class SearchIdleState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchErrorState extends SearchState {
  final String errorMessage;

  SearchErrorState({required this.errorMessage});
}

class SearchLoadedState extends SearchState {
  final List<SearchResult> result;

  SearchLoadedState({required this.result});
}
