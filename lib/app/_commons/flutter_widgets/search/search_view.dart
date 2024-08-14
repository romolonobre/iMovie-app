import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/_commons/extensions/extensions.dart';
import 'package:imovie_app/app/_commons/flutter_widgets/search/search_controller.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../app_services/utils.dart';
import '../../imovie_ui/iui_loader.dart';
import '../../imovie_ui/iui_text.dart';
import '../hero_dialog/custom_rect_tween.dart';
import 'seach_result.dart';
import 'search_state.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final controller = CustomSearchController();
  final SpeechToText voiceToText = SpeechToText();
  final TextEditingController textEditingController = TextEditingController();
  bool isListening = false;
  OverlayEntry? entry;
  Timer? debounce;
  String words = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  @override
  void dispose() {
    super.dispose();
    debounce?.cancel();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Hero(
              tag: "search",
              createRectTween: (begin, end) {
                return CustomRectTween(begin: begin!, end: end!);
              },
              child: Material(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(10),
                child: TextField(
                  autofocus: true,
                  controller: textEditingController,
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    _onSearchChanged(value);
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    hintText: 'Search Movies',
                    filled: true,
                    fillColor: Colors.white10,
                    border: InputBorder.none,
                    hintStyle: const TextStyle(color: Colors.white60, fontSize: 15),

                    // Textfield back button
                    prefixIcon: InkWell(
                      onTap: () => Modular.to.pop(),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white60,
                      ),
                    ),

                    // Mic button
                    suffixIcon: InkWell(
                      child: SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(
                              height: 20,
                              child: VerticalDivider(width: 1, color: Colors.white24),
                            ),
                            AvatarGlow(
                              glowColor: Colors.red,
                              animate: isListening,
                              glowRadiusFactor: 20,
                              child: Icon(
                                isListening ? Icons.mic : Icons.mic_none,
                                color: Colors.white60,
                              ).paddingOnly(left: 15, right: 15, top: 5, bottom: 5),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        if (voiceToText.isNotListening) {
                          _startListening();
                          return;
                        }
                        _stopListening();
                      },
                    ),
                  ),
                ).borderRadius(10),
              ).paddingOnly(left: 10, right: 20),
            ),

            // Result based on the state
            ValueListenableBuilder(
              valueListenable: controller,
              builder: (_, state, __) {
                return switch (state) {
                  SearchIdleState() => const SizedBox.shrink(),
                  SearchLoadingState() => const IUILoader(),
                  SearchErrorState state => _onErrorContainer(state.errorMessage),
                  SearchLoadedState state =>
                    state.result.isEmpty ? _noResultsContainer() : _resultsContainer(state.result),
                };
              },
            ),
          ],
        ),
      ),
    );
  }

  // Handle input changes with debounce
  void _onSearchChanged(String value) {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () async {
      if (value.length <= 4) {
        controller.reset();
        return;
      }
      await controller.search(value);
    });
  }

  // Widget to show when there are no search results
  Widget _noResultsContainer() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(15),
        color: backgroundColor.withOpacity(0.9),
        child: IUIText.heading("No movies found", color: Colors.white),
      ),
    );
  }

  // Widget to show when there is an error in the search
  Widget _onErrorContainer(String errorMessage) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(15),
        color: backgroundColor.withOpacity(0.9),
        child: IUIText.heading(errorMessage, color: Colors.red),
      ),
    );
  }

  // Widget to show the search results
  Widget _resultsContainer(List<SearchResult> results) {
    return SingleChildScrollView(
      child: Column(
        children: results.map(
          (result) {
            return ListTile(
              title: IUIText.heading(result.title, color: Colors.white),
              leading: Image.network(
                result.postPath,
                height: 80,
                width: 100,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 80,
                  width: 100,
                  decoration: const BoxDecoration(color: backgroundColor),
                ),
              ).borderRadius(8),
              onTap: () {
                FocusScope.of(context).unfocus();
                Modular.to.pushNamed('./details', arguments: result.id);
              },
            ).paddingOnly(top: 15);
          },
        ).toList(),
      ),
    );
  }

  // Init
  void _initSpeech() async {
    await voiceToText.initialize();

    setState(() {});
  }

  // Start listening to voice
  void _startListening() async {
    words = '';
    await voiceToText.listen(onResult: _onSpeechResult);
    isListening = true;
    setState(() {});
  }

  // Stop listening voice and search
  void _stopListening() async {
    await voiceToText.stop();
    isListening = false;
    _onSearchChanged(words);
    setState(() {});
  }

// Handle voice recognition results
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      words = result.recognizedWords;
      textEditingController.text = words;
    });
  }
}
