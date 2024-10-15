// ignore_for_file: control_flow_in_finally

import 'package:app_services/app_services.dart';
import 'package:http/http.dart';

import 'movie_details_datasource.dart';

class MovieDetailsDatasourceImpl extends APIRequest implements MovieDetailsDatasource {
  Future<TMDBApiResponse> _fetchData(String endpoint, {required String tag}) async {
    Response? response;
    try {
      response = await this.get(endpoint);
    } catch (error, stackTrace) {
      Errorhandler.report(error, stackTrace, tag: tag);
    } finally {
      return TMDBApiResponse(response);
    }
  }

  @override
  Future<TMDBApiResponse> getGenres({required String id}) async {
    return await _fetchData("3/movie/$id", tag: "getGenres");
  }

  @override
  Future<TMDBApiResponse> getDetails({required String id}) async {
    return await _fetchData("3/movie/$id", tag: "getDetails");
  }

  @override
  Future<TMDBApiResponse> getCast({required String id}) async {
    return await _fetchData("3/movie/$id/credits", tag: "getCast");
  }

  @override
  Future<TMDBApiResponse> getVideos({required String id}) async {
    return await _fetchData("3/movie/$id/videos", tag: "getVideos");
  }

  @override
  Future<TMDBApiResponse> getPhotos({required String id}) async {
    return await _fetchData("3/movie/$id/images", tag: "getPhotos");
  }

  @override
  Future<TMDBApiResponse> getReviews({required String id}) async {
    return await _fetchData("3/movie/$id/reviews", tag: "getreviews");
  }
}
