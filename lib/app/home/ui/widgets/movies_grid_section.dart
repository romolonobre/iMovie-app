import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/_commons/extensions/extensions.dart';
import 'package:imovie_app/app/_commons/imovie_ui/iui_grid_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../../_commons/imovie_ui/iui_text.dart';
import '../../data/movies_service.dart';
import '../../interactor/states/movies_state.dart';
import 'imdb_review_widget.dart';

class MoviesGridSection extends StatelessWidget {
  final String sectionTitle;
  final double height;
  final double width;
  final String endpoint;

  MoviesGridSection({
    super.key,
    required this.height,
    required this.width,
    required this.sectionTitle,
    required this.endpoint,
  });

  final service = Modular.get<MoviesService>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MoviesState>(
      future: service.gelAll(endpoint: endpoint),
      builder: (context, snapshot) {
        final state = snapshot.data;

        // Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmerEffect();
        }

        return Column(
          children: [
            Row(
              children: [
                IUIText.heading(
                  sectionTitle,
                  fontWeight: FontWeight.w800,
                  fontsize: 20,
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.white60,
                  size: 16,
                )
              ],
            ).paddingOnly(left: 20),
            const SizedBox(height: 10),
            //
            // Error State
            //
            if (state is MoviesErrorState)
              IUIText.heading(
                state.message,
                color: Colors.red,
                maxLines: 4,
              ).paddingOnly(left: 20, right: 20),
            //
            // Movies Loaded State
            //

            if (state is MoviesLoadedState)
              SizedBox(
                height: height,
                child: IUIGridView(
                  crossAxisSpacing: 8.0,
                  mainAxisExtent: width,
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return GestureDetector(
                      onTap: () => Modular.to.pushNamed('./details', arguments: movie.id),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //
                          // Movie Image
                          Expanded(
                            child: Material(
                              elevation: 10,
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(movie.postImage),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          SizedBox(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //
                                // Movie Name
                                Flexible(
                                  child: IUIText.heading(
                                    movie.title,
                                    fontsize: 12,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                const SizedBox(width: 5),

                                //
                                // IMDB icon
                                ImdbReviewWidget(review: movie.voteAverage),
                              ],
                            ),
                          ),

                          // Release Date
                          IUIText.heading(
                            movie.releaseDate.getYear(),
                            fontsize: 12,
                            color: Colors.blueGrey,
                          )
                        ],
                      ),
                    ).paddingOnly(left: index == 0 ? 20 : 0);
                  },
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildShimmerEffect() {
    return SizedBox(
      height: height,
      child: GridView.builder(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 8.0,
          mainAxisExtent: width,
        ),
        padding: const EdgeInsets.all(8.0),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade400,
            highlightColor: Colors.grey.shade400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  height: 12.0,
                  color: Colors.grey,
                ),
                const SizedBox(height: 5.0),
                Container(
                  width: 50.0,
                  height: 12.0,
                  color: Colors.grey,
                ),
                const SizedBox(height: 5.0),
                Container(
                  width: 30.0,
                  height: 12.0,
                  color: Colors.grey,
                ),
              ],
            ),
          );
        },
      ).paddingOnly(left: 20),
    );
  }
}
