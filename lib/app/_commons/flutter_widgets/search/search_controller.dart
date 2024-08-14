import 'package:flutter/material.dart';

import 'search_service.dart';
import 'search_state.dart';

class CustomSearchController extends ValueNotifier<SearchState> {
  CustomSearchController() : super(SearchIdleState());

  void _emit(SearchState state) => value = state;

  final service = SearchService();
  Future<void> search(String value) async {
    _emit(SearchLoadingState());
    final result = await service.search(value);
    _emit(result);
  }

  Future<void> reset() async {
    if (value is SearchIdleState) return;
    _emit(SearchIdleState());
  }
}
