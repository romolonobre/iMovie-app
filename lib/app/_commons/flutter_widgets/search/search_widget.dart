import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/_commons/flutter_widgets/hero_dialog/hero_dialog_route.dart';
import 'package:imovie_app/app/_commons/flutter_widgets/search/search_view.dart';

import '../hero_dialog/custom_rect_tween.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Modular.to.push(
        HeroDialogRoute(
          builder: (context) => const SearchView(),
        ),
      ),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width - 60,
        height: 45,
        child: Hero(
          tag: "search",
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },

          // Search button box
          child: Material(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.white60),
                  SizedBox(width: 10),
                  Text(
                    'Search Movies',
                    style: TextStyle(color: Colors.white60, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
