import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imovie_app/app/_commons/extensions/extensions.dart';
import 'package:imovie_app/app/_commons/flutter_widgets/video_player_screen.dart';
import 'package:imovie_app/app/_commons/imovie_ui/iui_text.dart';
import 'package:imovie_app/app/serie_details/interactor/serie_details_state.dart';

import '../../providers/serie_details_providers.dart';

class SeasonVideoSection extends ConsumerStatefulWidget {
  final String id;
  final String seasonNumber;
  const SeasonVideoSection({
    super.key,
    required this.id,
    required this.seasonNumber,
  });

  @override
  ConsumerState<SeasonVideoSection> createState() => _SeasonVideoSectionState();
}

class _SeasonVideoSectionState extends ConsumerState<SeasonVideoSection> {
  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(seasonVideosNotifierProvider.notifier).getSeasonVideos(
            id: widget.id,
            seasonNumber: widget.seasonNumber,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(seasonVideosNotifierProvider);

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
  }
}
