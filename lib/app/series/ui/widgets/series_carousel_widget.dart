import 'dart:async';

import 'package:flutter/material.dart';

import '../../../_commons/imovie_ui/iui_text.dart';
import '../../interactor/entities/series.dart';
import 'page_indicator_widget.dart';
import 'serie_details_content.dart';

class SeriesCarouselWidget extends StatefulWidget {
  final List<Serie> series;
  const SeriesCarouselWidget({super.key, required this.series});

  @override
  State<SeriesCarouselWidget> createState() => _SeriesCarouselWidgetState();
}

class _SeriesCarouselWidgetState extends State<SeriesCarouselWidget> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;
  final int _maxPages = 8;

  @override
  void initState() {
    super.initState();
    animateToNextPage();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            controller: _pageController,
            itemCount: 8,
            itemBuilder: (context, index) {
              final serie = widget.series[index];

              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  //
                  // Image
                  Image.network(
                    serie.postImage,
                    fit: BoxFit.cover,
                    height: 340,
                    width: double.infinity,
                  ),
                  //
                  // Shadow container
                  Container(height: 340, color: Colors.black26),

                  //
                  // Content
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(height: 10),
                      IUIText.title(serie.name, fontWeight: FontWeight.w900),
                      SerieDetailsContentWidget(id: serie.id),
                      const SizedBox(height: 10),
                    ],
                  )
                ],
              );
            },
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
          ),
        ),
        PageIndicatorWidget(
          currentPage: _currentPage,
          pages: _maxPages,
        ),
      ],
    );
  }

  void animateToNextPage() {
    _pageController = PageController(initialPage: 0);

    // Start a timer that triggers every 3 seconds.
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _maxPages - 1) {
        _currentPage++;
      }
      // If is the last page loop back to the first page
      else {
        _currentPage = 0;
      }

      // Animate to the next page
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }
}
