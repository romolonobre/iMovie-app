import 'package:app_services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:imovie_app/app/serie_details/interactor/serie_details_controller.dart';
import 'package:imovie_app/app/serie_details/interactor/serie_details_state.dart';
import 'package:imovie_ui/imovie_ui.dart';

class SeasonVideoSection extends StatefulWidget {
  final String id;
  final String seasonNumber;
  const SeasonVideoSection({
    super.key,
    required this.id,
    required this.seasonNumber,
  });

  @override
  State<SeasonVideoSection> createState() => _SeasonVideoSectionState();
}

class _SeasonVideoSectionState extends State<SeasonVideoSection> {
  final controller = Modular.get<SerieDetailsController>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller..getSeasonVideos(id: widget.id, seasonNumber: widget.seasonNumber),
      builder: (_, state, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            IUIText.title("Videos & Trailers", fontsize: 25),
            const SizedBox(height: 10),
            if (state is SeriesDetailsErrorState)
              IUIText.heading(
                state.message,
                fontsize: 14,
                color: Colors.red,
              ),

            // Empty state
            if (state is SerieSeasonVideosEmptyState) IUIText.title("No videos available"),

            // Loaded state
            if (state is SerieSeasonVideosLoadedState)
              ...state.videos.map(
                (video) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(8),
                        child: GestureDetector(
                          onTap: () {
                            Modular.to.push(
                              MaterialPageRoute(
                                builder: (context) => VideoPlayWidget(videoId: video.id),
                              ),
                            );
                          },

                          // Video Thumbnail
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.network(
                                "https://img.youtube.com/vi/${video.id}/0.jpg",
                                fit: BoxFit.fill,
                              ),
                              const Icon(
                                Icons.slow_motion_video_rounded,
                                color: Colors.white,
                                size: 60,
                              ),
                            ],
                          ),
                        ),
                      ),
                      IUIText.heading(
                        video.name,
                        fontsize: 18,
                        color: Colors.grey,
                      ).paddingOnly(bottom: 20),
                    ],
                  );
                },
              )
          ],
        );
      },
    );
  }
}
