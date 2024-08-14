import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/_commons/imovie_ui/iui_loader.dart';

import '../../_commons/app_services/utils.dart';
import '../../_commons/imovie_ui/iui_buttons.dart';
import '../data/movie_details_service.dart';
import '../interactor/states/movie_details_state.dart';
import 'widgets/cast_section.dart';
import 'widgets/movie_details_section.dart';
import 'widgets/photos_section.dart';
import 'widgets/videos_section.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String id;

  const MovieDetailsScreen({super.key, required this.id});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final service = Modular.get<MovieDetailsService>();

  @override
  void initState() {
    super.initState();
    service.getDetails(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: FutureBuilder<MovieDetailsState>(
          future: service.getDetails(id: widget.id),
          builder: (context, snapshot) {
            final state = snapshot.data;

            // Loading state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: IUILoader(),
              );
            }
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state is MovieDetailsLoadedState) ...{
                        //
                        // Image header
                        Container(
                          height: 310,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(state.movie.backgroundImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        MovieDetailsSection(movie: state.movie),
                        const SizedBox(height: 20),
                      },

                      // Divider
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        child: const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          endIndent: 35,
                          indent: 35,
                        ),
                      ),

                      const SizedBox(height: 15),

                      CastSection(
                        id: widget.id,
                        service: service,
                      ),
                      const SizedBox(height: 15),
                      VideosSection(
                        id: widget.id,
                        service: service,
                      ),
                      const SizedBox(height: 15),
                      PhotosSection(
                        id: widget.id,
                        service: service,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),

                // Back button
                Positioned(
                  top: 40,
                  left: 10,
                  child: IUIButtons.back(context),
                ),
              ],
            );
          }),
    );
  }
}
