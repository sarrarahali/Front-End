
import 'package:boy/Screens/NotificationSceen.dart';
import 'package:boy/Screens/PendingScreen.dart';
import 'package:boy/Screens/Profile/Screen/ProfileScreen.dart';
import 'package:boy/Screens/homependeingScreen.dart';
import 'package:boy/Screens/mainhome_Screen.dart';


import 'package:boy/Widgets/Colors.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unicons/unicons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; 
  final List<Widget> _screens = [
    
    
   MainScreenhome(),
   MainPendingScreen(),
    NotificationScreen(),
    ProfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavigationDestination(
              icon: Icon(UniconsLine.home , color: _selectedIndex == 0 ? Colors.amber : Colors.grey),
              onPressed: () {
                _onItemTapped(0);
              },
              selected: _selectedIndex == 0,
            ),
            _NavigationDestination(
              icon: Icon(Ionicons.timer_outline, color: _selectedIndex == 1 ? Colors.amber :  Colors.grey ),
              onPressed: () {
                _onItemTapped(1);
              },
              selected: _selectedIndex == 1,
            ),
            _NavigationDestination(
              icon: Icon(Icons.notifications_none, color: _selectedIndex == 2 ? Colors.amber : Colors.grey),
              onPressed: () {
                _onItemTapped(2);
              },
              selected: _selectedIndex == 2,
            ),
            _NavigationDestination(
              icon: Icon(UniconsLine.user , color: _selectedIndex == 3 ? Colors.amber : Colors.grey),
              onPressed: () {
                _onItemTapped(3);
              },
              selected: _selectedIndex == 3,
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class _NavigationDestination extends StatelessWidget {
  final Icon icon;
  final VoidCallback onPressed;
  final bool selected;

  _NavigationDestination({
    required this.icon,
    required this.onPressed,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
           children: [
            icon,
            SizedBox(height: 5,),
            if (selected) 
              Container(
                width: 8, 
                height: 8, 
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: GlobalColors.mainColor
                ),
              ),
          ],
        ),
      ),
    );
  }
}









