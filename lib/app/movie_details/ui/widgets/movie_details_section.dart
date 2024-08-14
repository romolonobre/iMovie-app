import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/_commons/extensions/extensions.dart';

import '../../../_commons/imovie_ui/iui_loader.dart';
import '../../../_commons/imovie_ui/iui_text.dart';
import '../../../_commons/movie/entities/movie.dart';
import '../../data/movie_details_service.dart';
import '../../interactor/states/movie_details_state.dart';
import 'imdb_review_widget.dart';
import 'movie_reviews_section.dart';

class MovieDetailsSection extends StatelessWidget {
  final Movie movie;

  MovieDetailsSection({super.key, required this.movie});

  final service = Modular.get<MovieDetailsService>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieDetailsState>(
      future: service.getGenres(id: movie.id),
      builder: (context, snapshot) {
        final state = snapshot.data;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 170,
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(movie.postImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IUIText.heading(movie.title, fontWeight: FontWeight.w800),
                          const SizedBox(width: 5),
                          IUIText.heading(
                            "(${movie.releaseDate.getYear()})",
                            fontsize: 12,
                            color: Colors.blueGrey,
                          )
                        ],
                      ),
                      ImdbReviewWidget(review: movie.voteAverage),
                      const SizedBox(height: 10),
                      FittedBox(
                        child: SizedBox(
                          width: 220,
                          child: IUIText.heading(
                            movie.description,
                            fontWeight: FontWeight.w500,
                            fontsize: 11,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Loading state
                      if (snapshot.connectionState == ConnectionState.waiting) const IUILoader(size: 20),

                      //Error state
                      if (state is MoviesDetailsErrorState)
                        IUIText.heading(
                          state.message,
                          color: Colors.red,
                          maxLines: 4,
                        ).paddingOnly(left: 20, right: 20),

                      if (state is MovieGenreLoadedState)
                        Wrap(
                          direction: Axis.horizontal,
                          children: [
                            ...state.genre.map(
                              (e) => Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.white54,
                                        ),
                                      ),
                                      child: IUIText.heading(
                                        e.name,
                                        fontsize: 10,
                                        fontWeight: FontWeight.w700,
                                      ).paddingAll(3))
                                  .paddingAll(3),
                            ),
                          ],
                        ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: MovieReviewsSection(
                          id: movie.id,
                          service: service,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ).paddingOnly(left: 20),
          ],
        );
      },
    );
  }
}

extension RatingLabelExtension on double {
  String get ratingLabel {
    if (this >= 9.0) {
      return 'Excellent';
    } else if (this >= 7.0) {
      return 'Good';
    } else if (this >= 6.0) {
      return 'Average';
    } else if (this >= 4.0) {
      return 'Poor';
    } else {
      return 'Very Poor';
    }
  }
}
