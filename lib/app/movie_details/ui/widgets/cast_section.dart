// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:imovie_app/app/_commons/extensions/extensions.dart';
import 'package:imovie_app/app/movie_details/interactor/states/movie_details_state.dart';

import '../../../_commons/imovie_ui/iui_grid_view.dart';
import '../../../_commons/imovie_ui/iui_loader.dart';
import '../../../_commons/imovie_ui/iui_text.dart';
import '../../data/movie_details_service.dart';

class CastSection extends StatelessWidget {
  final String id;
  final MovieDetailsService service;
  const CastSection({
    super.key,
    required this.id,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieDetailsState>(
      future: service.getCast(id: id),
      builder: (context, snapshot) {
        final state = snapshot.data;

        return Column(
          children: [
            Row(
              children: [
                IUIText.heading(
                  "Cast",
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
            if (snapshot.connectionState == ConnectionState.waiting) const IUILoader(size: 40),

            if (state is MoviesDetailsErrorState)
              IUIText.heading(
                state.message,
                color: Colors.red,
                fontsize: 12,
              ),
            if (state is MovieCastLoadedState)
              SizedBox(
                height: 120,
                child: IUIGridView(
                  itemCount: state.casts.length,
                  itemBuilder: (_, index) {
                    final cast = state.casts[index];
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
                                  image: NetworkImage(cast.image),
                                  fit: BoxFit.fitWidth,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        IUIText.heading(cast.name, fontsize: 9, fontWeight: FontWeight.w700),
                        IUIText.heading(cast.character, fontsize: 9, color: Colors.grey)
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
