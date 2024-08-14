import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/_commons/extensions/extensions.dart';

import '../../../_commons/flutter_widgets/video_player_screen.dart';
import '../../../_commons/imovie_ui/iui_grid_view.dart';
import '../../../_commons/imovie_ui/iui_loader.dart';
import '../../../_commons/imovie_ui/iui_text.dart';
import '../../data/movie_details_service.dart';
import '../../interactor/states/movie_details_state.dart';

class VideosSection extends StatelessWidget {
  final String id;
  final MovieDetailsService service;
  const VideosSection({
    super.key,
    required this.id,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieDetailsState>(
      future: service.getVideos(id: id),
      builder: (context, snapshot) {
        final state = snapshot.data;

        return Column(
          children: [
            Row(
              children: [
                IUIText.heading(
                  "Videos",
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

            //  Error state
            if (state is MoviesDetailsErrorState)
              IUIText.heading(
                state.message,
                color: Colors.red,
                fontsize: 12,
              ),
            if (state is MovieVideosLoadedState)
              SizedBox(
                height: 83,
                child: IUIGridView(
                  itemCount: state.videosId.length,
                  mainAxisExtent: 160,
                  itemBuilder: (_, index) {
                    final videoId = state.videosId[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(8),
                            child: GestureDetector(
                              onTap: () {
                                Modular.to.push(
                                  MaterialPageRoute(
                                    builder: (context) => VideoPlayWidget(videoId: videoId),
                                  ),
                                );
                              },

                              // Video Thumbnail
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage("https://img.youtube.com/vi/$videoId/0.jpg"),
                                        fit: BoxFit.fitWidth,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.slow_motion_video_rounded,
                                    color: Colors.white,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
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
