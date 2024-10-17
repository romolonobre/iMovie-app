import 'package:app_services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:imovie_ui/imovie_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../interactor/serie_controller.dart';
import '../../interactor/series_states.dart';

class SerieDetailsContentWidget extends StatelessWidget {
  final String id;

  bool isDetailsScreen;

  SerieDetailsContentWidget({
    super.key,
    required this.id,
    this.isDetailsScreen = false,
  });

  final controller = Modular.get<SerieController>();

  @override
  Widget build(BuildContext context) {
    final double buttonSize = MediaQuery.sizeOf(context).width - 60;

    return ValueListenableBuilder(
      valueListenable: controller..getDetails(id),
      builder: (_, state, child) {
        //Loading state
        if (state is SeriesLoadingState) {
          return const IUILoader(size: 20);
        }
        // Error state
        if (state is SeriesErrorState) {
          return IUIText.heading(
            state.message,
            color: Colors.red,
            fontsize: 12,
          );
        }

        // Loaded State
        if (state is SerieDetailsLoadedState) {
          return Column(
            children: [
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                runSpacing: 2,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IUIText.heading('${state.details.seasons.length} Seasons - '),
                      IUIText.heading('${state.details.releaseDate.getYear()} - '),
                      ImdbReviewWidget(review: state.details.vote)
                    ],
                  ),

                  //
                  // Genres
                  ...state.details.genres.map(
                    (e) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xff242226),
                        ),
                        child: IUIText.heading(
                          e.name,
                          fontsize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ).paddingAll(5),
                      ).paddingAll(3);
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  //
                  // Watchlist button
                  IUIButtons.icon(
                    icon: Icons.add,
                    label: 'Watchlist',
                    width: buttonSize,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 10),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      //
                      // Play button
                      IUIButtons.icon(
                        icon: Icons.play_arrow,
                        label: 'Play',
                        width: buttonSize,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        onPressed: () {
                          _launchURL(state.details.homePageLink);
                        },
                      ),
                      IUIText.heading(
                        "(External Link)",
                        fontsize: 10,
                        color: Colors.black,
                      ).paddingOnly(right: 10)
                    ],
                  ),
                ],
              ).paddingOnly(bottom: 10, top: 10)
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse('dsds'))) {
      await launchUrl(Uri.parse(url));
    } else {
      IUISnackbar.show(
        Utils.navigatorKey.currentContext!,
        message: "Could not launch $url",
        isError: true,
      );
    }
  }
}
