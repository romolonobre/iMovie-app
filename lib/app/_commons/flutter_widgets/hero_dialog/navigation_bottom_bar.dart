import 'package:flutter/material.dart';
import 'package:imovie_app/app/_commons/remote_config/remote_config.dart';
import 'package:imovie_ui/imovie_ui.dart';

class NavigationBottomBar extends StatefulWidget {
  final List<Widget> screens;
  const NavigationBottomBar({super.key, required this.screens});

  @override
  State<NavigationBottomBar> createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff242226),
      bottomNavigationBar: SizedBox(
        child: Theme(
          data: ThemeData(
            navigationBarTheme: NavigationBarThemeData(
              indicatorColor: IUIPalette.primaryColor,
              backgroundColor: Colors.black,
              labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
                (states) {
                  if (states.contains(WidgetState.selected)) {
                    return const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    );
                  }
                  return TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  );
                },
              ),
            ),
          ),
          child: NavigationBar(
            animationDuration: const Duration(seconds: 1),
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) => setState(() => selectedIndex = value),
            destinations: [
              const NavigationDestination(
                  icon: Icon(
                    Icons.home_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                  label: "Home"),
              const NavigationDestination(
                  icon: Icon(
                    Icons.tv,
                    color: Colors.white,
                  ),
                  label: "Tv Series"),
              if (showProfile())
                const NavigationDestination(
                    icon: Icon(
                      Icons.person_2_outlined,
                      color: Colors.white,
                    ),
                    label: "Profile"),
            ],
          ),
        ),
      ),
      body: widget.screens[selectedIndex],
    );
  }

  bool showProfile() {
    return CustomRemoteConfig().getValueOrDefault(key: "showProfile", defaultValue: false);
  }
}
