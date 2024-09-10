// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imovie_app/app/_commons/extensions/extensions.dart';

import '../../../_commons/flutter_widgets/shimmer_loading.dart';
import '../../../_commons/imovie_ui/iui_text.dart';
import '../../interactor/serie_details_state.dart';
import '../../providers/serie_details_providers.dart';
import 'episode_details_expansion_tile.dart';
import 'season_selector.dart';
import 'season_video_section.dart';

class EpisodesSection extends ConsumerStatefulWidget {
  final String id;

  const EpisodesSection({super.key, required this.id});

  @override
  ConsumerState<EpisodesSection> createState() => _EpisodesSectionState();
}

class _EpisodesSectionState extends ConsumerState<EpisodesSection> {
  String seasonNumber = "1";

  @override
  void initState() {
    super.initState();
    Future(
      () => ref.read(seasonsNotifierProvider.notifier).getSeasons(
            id: widget.id,
            seasonNumber: seasonNumber,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(seasonsNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SeasonSelector(
          id: widget.id,
          getSeasonNumber: (e) =>
              ref.read(seasonsNotifierProvider.notifier).getSeasons(id: widget.id, seasonNumber: e.toString()),
        ),
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
  }
}
