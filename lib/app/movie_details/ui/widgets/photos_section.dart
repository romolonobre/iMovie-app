import 'package:flutter/material.dart';
import 'package:imovie_app/app/_commons/extensions/extensions.dart';

import '../../../_commons/imovie_ui/iui_grid_view.dart';
import '../../../_commons/imovie_ui/iui_loader.dart';
import '../../../_commons/imovie_ui/iui_text.dart';
import '../../data/movie_details_service.dart';
import '../../interactor/states/movie_details_state.dart';

class PhotosSection extends StatelessWidget {
  final String id;
  final MovieDetailsService service;
  const PhotosSection({super.key, required this.id, required this.service});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieDetailsState>(
      future: service.getPhotos(id: id),
      builder: (context, snapshot) {
        final state = snapshot.data;

        return Column(
          children: [
            Row(
              children: [
                IUIText.heading(
                  "Photos",
                  fontsize: 18,
                  fontWeight: FontWeight.w600,
                ).paddingOnly(left: 25, right: 5),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                  size: 14,
                )
              ],
            ),
            // Loading state
            if (snapshot.connectionState == ConnectionState.waiting) const IUILoader(size: 20),

            //Error state
            if (state is MoviesDetailsErrorState)
              IUIText.heading(
                state.message,
                color: Colors.red,
                fontsize: 12,
              ),

            if (state is MoviePhotosLoadedState)
              SizedBox(
                height: 160,
                child: IUIGridView(
                  itemCount: state.photosUrl.length,
                  mainAxisExtent: 130,
                  itemBuilder: (_, index) {
                    final photoUrl = state.photosUrl[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(photoUrl),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4.0),
                      ],
                    ).paddingOnly(left: index == 0 ? 20 : 0);
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
