import 'package:flutter/material.dart';
import 'package:news_app/pages/tab1_page.dart';
import 'package:news_app/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: Scaffold(
        body: SafeArea(child: _Pages()),
        bottomNavigationBar: _BottomNavigationBar(),
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
      currentIndex: navigationModel.actualPage,
      onTap: (i) => navigationModel.actualPage = i,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'For You',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label: 'Headlines',
        ),
      ],
    );
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);
    return PageView(
      // physics: const BouncingScrollPhysics(),
      controller: navigationModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [TabOnePage(), TabTwoPage()],
    );
  }
}

//  Mixin ChangeNotifier: https://stackoverflow.com/questions/57243896/with-keyword-in-flutter
class _NavigationModel with ChangeNotifier {
  int _actualPage = 0;
  final PageController _pageController = PageController();

  int get actualPage => _actualPage;

  set actualPage(int value) {
    _actualPage = value;
    _pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
