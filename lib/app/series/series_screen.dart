// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/_commons/extensions/extensions.dart';

import '../_commons/app_services/utils.dart';
import '../_commons/imovie_ui/iui_grid_view.dart';
import '../_commons/imovie_ui/iui_loader.dart';
import '../_commons/imovie_ui/iui_text.dart';
import 'interactor/serie_controller.dart';
import 'interactor/series_states.dart';
import 'ui/widgets/series_carousel_widge.dart';

class SeriesScreen extends StatelessWidget {
  SeriesScreen({super.key});

  final controller = Modular.get<SerieController>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<SeriesState>(
      valueListenable: controller..getSeries(),
      builder: (_, state, child) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Loading state
              if (state is SeriesLoadingState)
                const Center(
                  heightFactor: 8,
                  child: IUILoader(
                    size: 50,
                    message: "Loading...",
                  ),
                ),

              // Error state
              if (state is SeriesErrorState)
                Center(
                  heightFactor: 14,
                  child: IUIText.heading(
                    state.message,
                    color: Colors.red,
                    fontsize: 15,
                  ),
                ).paddingOnly(left: 10, right: 10),

              if (state is SeriesLoadedState)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SeriesCarouselWidget(series: state.series),
                      IUIText.title(
                        "Tv Series",
                        fontWeight: FontWeight.bold,
                      ).paddingOnly(left: 20, top: 10),
                      Expanded(
                        child: IUIGridView(
                          scrollDirection: Axis.vertical,
                          crossAxisCount: 3,
                          mainAxisExtent: 200,
                          itemCount: state.series.length,
                          itemBuilder: (context, index) {
                            final serie = state.series[index];

                            return Column(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Modular.to.pushNamed('./serie-details', arguments: serie);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(serie.postImage),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ).paddingOnly(left: 10, right: 10),
                      )
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
