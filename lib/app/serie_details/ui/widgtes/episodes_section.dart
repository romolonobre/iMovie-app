// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/_commons/imovie_ui/iui_text.dart';

import '../../../_commons/flutter_widgets/shimmer_loading.dart';
import '../../interactor/serie_details_controller.dart';
import '../../interactor/serie_details_state.dart';
import 'episode_details_expansion_tile.dart';
import 'season_selector.dart';
import 'season_video_section.dart';

class EpisodesSection extends StatefulWidget {
  final String id;

  const EpisodesSection({super.key, required this.id});

  @override
  State<EpisodesSection> createState() => _EpisodesSectionState();
}

class _EpisodesSectionState extends State<EpisodesSection> {
  final controller = Modular.get<SerieDetailsController>();
  String seasonNumber = "1";

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller..getSeasons(id: widget.id, seasonNumber: '1'),
      builder: (_, state, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SeasonSelector(
                id: widget.id,
                getSeasonNumber: (e) async {
                  await controller.getSeasons(
                    id: widget.id,
                    seasonNumber: e.toString(),
                  );
                }),
            const SizedBox(height: 20),
            //
            // Loading state
            if (state is SeriesDetailsLoadingState)
              ShimmerLoading(
                width: MediaQuery.sizeOf(context).width - 50,
                height: 70,
                itemCount: 5,
                direction: Axis.vertical,
              ),

            //
            // Error state
            if (state is SeriesDetailsErrorState)
              IUIText.heading(
                state.message,
                color: Colors.red,
              ).paddingOnly(left: 20, right: 20),

            //
            // Loaded state
            if (state is SerieSeasonLoadedState)
              Column(
                children: [
                  ...state.seasons.map(
                    (season) {
                      seasonNumber = season.seasonNumber.toString();

                      return EpisodeDetailsExpansionTile(season: season);
                    },
                  ),
                ],
              ),
            SeasonVideoSection(
              id: widget.id,
              seasonNumber: seasonNumber,
            )
          ],
        );
      },
    );
  }
}
