import 'package:imovie_app/app/_commons/app_services/helper.dart';

import '../../app_services/utils.dart';
import 'seach_result.dart';
import 'search_datasource.dart';
import 'search_state.dart';

class SearchService {
  final data = SearchDatasource();

  Future<SearchState> search(String value) async {
    try {
      final response = await data(value);
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
