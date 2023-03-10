import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:newsapp/src/pages/pages.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const <Widget>[
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

class _Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
      currentIndex: navigationModel.currentPage,
      onTap: (index) => navigationModel.currentPage = index,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'For you',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label: 'Headlines',
        ),
      ],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _currentPage = 0;

  final PageController _pageController = PageController();

  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;

    _pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );

    notifyListeners();
  }

  PageController get pageController => _pageController;
}
