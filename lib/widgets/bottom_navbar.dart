import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/marketplace_page.dart';
import '../pages/profilepage.dart';
import '../pages/finbuddy_page.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    FinbuddyPage(), //finbussy
    MarketPage(), //marketplace
    const ProfilePage(), //userprofile
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavTheme = Theme.of(context).bottomNavigationBarTheme;
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            bottomNavTheme.backgroundColor, // Sets the violet-like color
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.chat), label: "Finbuddy"),
          const BottomNavigationBarItem(
              icon: const Icon(Icons.store), label: "Market"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
