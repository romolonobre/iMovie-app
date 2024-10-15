// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/series/interactor/entities/series.dart';

import '../../_commons/imovie_ui/iui_buttons.dart';
import '../../_commons/imovie_ui/iui_text.dart';
import '../../series/interactor/serie_controller.dart';
import '../../series/ui/widgets/serie_details_content.dart';
import 'widgtes/episodes_section.dart';

class SerieDetailsScreen extends StatefulWidget {
  final Serie serie;
  const SerieDetailsScreen({required this.serie, super.key});

  @override
  State<SerieDetailsScreen> createState() => _SerieDetailsScreenState();
}

class _SerieDetailsScreenState extends State<SerieDetailsScreen> {
  final SerieController controller = Modular.get<SerieController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.network(
                      widget.serie.backgroundImage,
                      fit: BoxFit.cover,
                      height: 360,
                      width: double.infinity,
                    ),
                    Container(height: 360, color: Colors.black26),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(height: 10),
                        IUIText.title(widget.serie.name, fontWeight: FontWeight.w900),
                        SerieDetailsContentWidget(id: widget.serie.id, isDetailsScreen: true),
                      ],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    IUIText.heading(
                      widget.serie.description,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 20),
                    EpisodesSection(id: widget.serie.id),
                    const SizedBox(height: 80),
                  ],
                ).paddingOnly(left: 20, right: 20)
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
      ),
    );
  }
}
