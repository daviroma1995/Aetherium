import 'package:aetherium_salon/screens/agenda_screen.dart';
import 'package:aetherium_salon/screens/client_card_screen.dart';
import 'package:aetherium_salon/screens/home/home_screen.dart';
import 'package:aetherium_salon/screens/profile_screen.dart';
import 'package:aetherium_salon/themes/navigation_theme.dart';
import 'package:aetherium_salon/themes/themes.dart';
import 'package:aetherium_salon/widgets/custom/navigation/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FullAppScreen extends StatefulWidget {
  const FullAppScreen({super.key});

  @override
  _FullApp createState() => _FullApp();
}

class _FullApp extends State<FullAppScreen> {
  int _currentIndex = 1;
  PageController? _pageController;

  late NavigationTheme navigationTheme;

  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    _pageController = PageController(initialPage: 1);
    navigationTheme = NavigationTheme.getNavigationTheme();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme.copyWith(colorScheme: theme.colorScheme.copyWith(secondary: theme.primaryColor.withAlpha(10))),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: Scaffold(
            body: SizedBox.expand(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                children: const <Widget>[AgendaScreen(), HomeScreen(), ClientCardScreen(), ProfileScreen()],
              ),
            ),
            bottomNavigationBar: CustomBottomNavigation(
              animationDuration: const Duration(milliseconds: 350),
              selectedItemOverlayColor: navigationTheme.selectedOverlayColor,
              backgroundColor: navigationTheme.backgroundColor,
              selectedIndex: _currentIndex,
              onItemSelected: (index) {
                setState(() => _currentIndex = index);
                _pageController!.jumpToPage(index);
              },
              items: <CustomBottomNavigationBarItem>[
                CustomBottomNavigationBarItem(
                    title: "Home",
                    icon: const Icon(MdiIcons.storeOutline, size: 22),
                    activeIcon: const Icon(MdiIcons.store, size: 22),
                    activeColor: navigationTheme.selectedItemColor,
                    inactiveColor: navigationTheme.unselectedItemColor),
                CustomBottomNavigationBarItem(
                    title: "Search",
                    icon: const Icon(MdiIcons.magnify, size: 22),
                    activeIcon: const Icon(MdiIcons.magnify, size: 22),
                    activeColor: navigationTheme.selectedItemColor,
                    inactiveColor: navigationTheme.unselectedItemColor),
                CustomBottomNavigationBarItem(
                    title: "Cart",
                    icon: const Icon(MdiIcons.cartOutline, size: 22),
                    activeIcon: const Icon(MdiIcons.cart, size: 22),
                    activeColor: navigationTheme.selectedItemColor,
                    inactiveColor: navigationTheme.unselectedItemColor),
                CustomBottomNavigationBarItem(
                    title: "Profile",
                    icon: const Icon(
                      MdiIcons.accountOutline,
                      size: 22,
                    ),
                    activeIcon: const Icon(
                      MdiIcons.account,
                      size: 22,
                    ),
                    activeColor: navigationTheme.selectedItemColor,
                    inactiveColor: navigationTheme.unselectedItemColor),
              ],
            ),
          )),
    );
  }
}
