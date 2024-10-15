import 'package:app_services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_ui/imovie_ui.dart';

import '../../../_commons/flutter_widgets/hero_dialog/popup_card_tile.dart';
import '../../../series/interactor/entities/serie_details.dart';
import '../../../series/interactor/serie_controller.dart';
import '../../../series/interactor/series_states.dart';
import 'select_item.dart';

class SeasonSelector extends StatefulWidget {
  final String id;
  final Function(int) getSeasonNumber;

  const SeasonSelector({
    super.key,
    required this.id,
    required this.getSeasonNumber,
  });

  @override
  State<SeasonSelector> createState() => _SeasonSelectorState();
}

class _SeasonSelectorState extends State<SeasonSelector> {
  String? selectedSeason;
  final SerieController controller = Modular.get<SerieController>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller..getDetails(widget.id),
      builder: (_, state, child) {
        if (state is SerieDetailsLoadedState) {
          return Column(
            children: [
              PopupCardTile(
                id: 'details',
                cardTitle: 'Select Season',
                cardSubtitle: '',
                //
                // Visible content on the view
                visibleContent: Container(
                  width: MediaQuery.sizeOf(context).width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IUIText.heading(
                        selectedSeason ?? getLabel(state.details),
                        fontWeight: FontWeight.w700,
                        fontsize: 18,
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Colors.white,
                        size: 30,
                      )
                    ],
                  ).paddingOnly(left: 20, right: 10),
                ),
                //
                // Pop up content
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: 200.0,
                    maxHeight: 400.0,
                    minWidth: MediaQuery.sizeOf(context).width - 40,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...state.details.seasons.map((season) {
                          return SelectItem(label: season.name);
                        }).toList()
                      ],
                    ),
                  ),
                ),
                callBack: (e) => setState(() {
                  var select = state.details.seasons.firstWhere((element) => element.name == e);
                  selectedSeason = e;
                  widget.getSeasonNumber(select.seasonNumber);
                }),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  String getLabel(SerieDetails details) {
    for (var season in details.seasons) {
      if (season.name.contains("Specials")) continue;
      return season.name;
    }
    return '';
  }
}
