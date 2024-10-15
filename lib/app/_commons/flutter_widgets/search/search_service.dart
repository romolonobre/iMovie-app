import 'package:app_services/app_services.dart';

import 'seach_result.dart';
import 'search_datasource.dart';
import 'search_state.dart';

class SearchService {
  final SearchDatasource datasource;

  SearchService({required this.datasource});

  Future<SearchState> search(String value) async {
    try {
      final response = await datasource(value);
      List<SearchResult> results = [];

      if (response.hasError) {
        return SearchErrorState(errorMessage: response.errorMessage);
      }
      response.data["results"].forEach((e) {
        final SearchResult result = SearchResult(
          id: Helper.getString(e["id"]),
          title: Helper.getString(e["original_title"]),
          postPath: imageBasePath + Helper.getString(e["backdrop_path"]),
        );
        results.add(result);
      });

      return SearchLoadedState(result: results);
    } catch (e) {
      return SearchErrorState(errorMessage: e.toString());
    }
  }
}
