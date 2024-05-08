import 'package:flutter/material.dart';
import 'package:reserviov1/constants/constants.dart';
import 'package:reserviov1/screens/home/Acceuil.dart';
import 'package:reserviov1/screens/Fevoirs.dart';
import 'package:reserviov1/screens/profile/profile.dart';

class bar extends StatefulWidget {
  const bar({super.key});

  @override
  State<bar> createState() => _barState();
}

class _barState extends State<bar> {
  int _selectedIndex = 0;

  void _onTappedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _Pages = [
    Acceuil(),
    MesFavoris(),
    profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//-----------------bottom barre mt3 Client normale --------------------------------
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.blue[400],
        showUnselectedLabels: true,
        selectedItemColor: blueColor,
        currentIndex: _selectedIndex,
        onTap: _onTappedItem,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Acceuil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Fevoirs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: _Pages[_selectedIndex],
    );
  }
}
