import 'package:app_services/app_services.dart';
import 'package:flutter/material.dart';

import '../../../_commons/imovie_ui/iui_text.dart';
import '../../interactor/entities/serie_season.dart';

class EpisodeDetailsExpansionTile extends StatefulWidget {
  final SerieSeason season;
  const EpisodeDetailsExpansionTile({
    Key? key,
    required this.season,
  }) : super(key: key);

  @override
  State<EpisodeDetailsExpansionTile> createState() => _EpisodeDetailsExpansionTileState();
}

class _EpisodeDetailsExpansionTileState extends State<EpisodeDetailsExpansionTile> {
  bool isExpaded = false;
  bool isAnimating = false;
  final expansionTileKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: expansionTileKey,
      decoration: BoxDecoration(
        color: Colors.blueGrey[900],
      ),
      //
      // Use theme to remove top and bottom borders
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (value) async {
            isExpaded = value;
            onExpanded(value);
          },
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          subtitle: IUIText.heading(
            widget.season.name,
            fontWeight: FontWeight.bold,
            fontsize: 16,
            color: Colors.grey,
          ),
          //
          // Visible content
          title: Row(
            children: [
              IUIText.heading(
                "S${widget.season.seasonNumber}",
                fontWeight: FontWeight.bold,
                fontsize: 20,
              ),
              IUIText.heading(
                "E${widget.season.episodeNumber}",
                fontWeight: FontWeight.bold,
                fontsize: 18,
              ),
            ],
          ),
          //
          // Expanded content
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isAnimating ? 1 : 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      //  Image
                      Image.network(
                        widget.season.postImage,
                        width: 140,
                        height: 100,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 140,
                            height: 100,
                            color: Colors.grey.shade500,
                            child: const Icon(Icons.info),
                          ).borderRadius(6);
                        },
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //
                          // Date
                          IUIText.heading(
                            widget.season.airDate.getFullDate(),
                            fontWeight: FontWeight.bold,
                            fontsize: 16,
                            color: Colors.grey,
                          ),
                          //
                          // Minutes
                          IUIText.heading(
                            "${widget.season.runTime}min",
                            fontWeight: FontWeight.bold,
                            fontsize: 15,
                            color: Colors.grey,
                          ),
                          //
                          // vote average
                          IUIText.heading(
                            widget.season.voteAverage.toStringAsFixed(1),
                            fontsize: 12,
                            color: Colors.amber,
                          ),
                        ],
                      )
                    ],
                  ),
                  //
                  // Description
                  IUIText.heading(
                    widget.season.description,
                    fontsize: 13,
                    color: Colors.white,
                  ).paddingOnly(bottom: 10),
                ],
              ).paddingOnly(left: 20, right: 20),
            )
          ],
        ),
      ),
    ).borderRadius(8).paddingOnly(bottom: 10);
  }

  void onExpanded(bool value) {
    if (value) {
      if (value) expansionTileKey.ensureVisible();
      setState(() => isAnimating = false);
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() => isAnimating = true);
      });
    }
    isAnimating = false;
  }
}
