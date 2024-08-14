// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:imovie_app/app/_commons/app_services/helper.dart';
import 'package:imovie_app/app/_commons/movie/adapters/movie_adapter.dart';

import '../../_commons/movie/entities/movie.dart';
import '../interactor/entities/cast.dart';
import '../interactor/entities/genres.dart';
import '../interactor/entities/review.dart';
import '../interactor/states/movie_details_state.dart';
import 'adapters/cast_adpater.dart';
import 'adapters/reviews_adapter.dart';
import 'movies_details_datasource.dart';

class MovieDetailsService {
  MovieDetailsDatasource datasource;
  MovieDetailsService({
    required this.datasource,
  });

  Future<MovieDetailsState> getDetails({required String id}) async {
    try {
      final response = await datasource.getDetails(id: id);

      if (response.hasError) {
        return MoviesDetailsErrorState(message: response.errorMessage);
      }

      final Movie movie = MovieAdapter().fromJson(response.data);

      return MovieDetailsLoadedState(movie: movie);
    } catch (e) {
      return MoviesDetailsErrorState(message: e.toString());
    }
  }

  Future<MovieDetailsState> getGenres({required String id}) async {
    try {
      final response = await datasource.getGenres(id: id);
      final List<Genre> genres = [];

      if (response.hasError) {
        return MoviesDetailsErrorState(message: response.errorMessage);
      }

      response.data['genres'].forEach((json) {
        genres.add(
          Genre(
            id: Helper.getString(['id']),
            name: Helper.getString(json['name']),
          ),
        );
      });

      return MovieGenreLoadedState(genre: genres);
    } catch (e) {
      return MoviesDetailsErrorState(message: e.toString());
    }
  }

  Future<MovieDetailsState> getCast({required String id}) async {
    try {
      final response = await datasource.getCast(id: id);
      if (response.hasError) {
        return MoviesDetailsErrorState(message: response.errorMessage);
      }

      final List<Cast> casts = CastAdapter().fromJsonToList(response.data);

      return MovieCastLoadedState(casts: casts);
    } catch (e) {
      return MoviesDetailsErrorState(message: e.toString());
    }
  }

  Future<MovieDetailsState> getVideos({required String id}) async {
    try {
      final response = await datasource.getVideos(id: id);
      List<String> videosId = [];
      if (response.hasError) {
        return MoviesDetailsErrorState(message: response.errorMessage);
      }

      response.data['results'].forEach((json) {
        final String path = Helper.getString(json["key"]);

        videosId.add(path);
      });

      return MovieVideosLoadedState(videosId: videosId);
    } catch (e) {
      return MoviesDetailsErrorState(message: e.toString());
    }
  }

  Future<MovieDetailsState> getPhotos({required String id}) async {
    const String imageBasePath = "https://image.tmdb.org/t/p/w400";
    try {
      final response = await datasource.getPhotos(id: id);
      List<String> photosUrl = [];

      if (response.hasError) {
        return MoviesDetailsErrorState(message: response.errorMessage);
      }

      response.data['backdrops'].forEach((json) {
        final String path = Helper.getString(json["file_path"]);
        String url = imageBasePath + path;

        photosUrl.add(url);
      });

      return MoviePhotosLoadedState(photosUrl: photosUrl);
    } catch (e) {
      return MoviesDetailsErrorState(message: e.toString());
    }
  }

  Future<MovieDetailsState> getReviews({required String id}) async {
    try {
      final response = await datasource.getreviews(id: id);
      if (response.hasError) {
        return MoviesDetailsErrorState(message: response.errorMessage);
      }

      List<Review> reviews = ReviewsAdapter().fromJsonToList(response.data);

      return MovieReviewsLoadedState(reviews: reviews);
    } catch (e) {
      return MoviesDetailsErrorState(message: e.toString());
    }
  }
}
