import 'package:flutter/material.dart';
import 'main.dart';
import 'second_page.dart';
import 'expenditure_page.dart';
import 'graph_page.dart';

class NavigationShell extends StatefulWidget {
  const NavigationShell({Key? key}) : super(key: key);

  @override
  NavigationShellState createState() => NavigationShellState();
}

class NavigationShellState extends State<NavigationShell> {
  int _currentIndex = 0;

  final List<Map<String, String>> _categories = [];

  List<Widget> get _pages => [
    MyHomePage(),
    SecondPage(categories: _categories),
    ExpenditurePage(categories: _categories),
    GraphPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void updateCategories(List<Map<String, String>> categories) {
    setState(() {
      _categories.clear();
      _categories.addAll(categories);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Expenditure',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Graph',
          ),
        ],
      ),
    );
  }
}
