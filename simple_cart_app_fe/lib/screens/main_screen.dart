import 'package:flutter/material.dart';
import './home_screen.dart';
import '../widgets/custom_bottom_nav.dart';

class MainScreen extends StatefulWidget{
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>{
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(child: Text('Wishlist Screen')),
    const Center(child: Text('Profile Screen')),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: CustomeBottomNav(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}