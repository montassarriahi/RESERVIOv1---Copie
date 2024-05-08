import 'package:flutter/material.dart';
import 'package:reserviov1/constants/constants.dart';
import 'package:reserviov1/screens/home/Acceuil.dart';
import 'package:reserviov1/screens/Fevoirs.dart';
import 'package:reserviov1/screens/features/prop/MesSalles.dart';
import 'package:reserviov1/screens/features/prop/addsalle.dart';
import 'package:reserviov1/screens/profile/profile.dart';

class barP extends StatefulWidget {
  const barP({super.key});

  @override
  State<barP> createState() => _barPState();
}

class _barPState extends State<barP> {
  int _selectedIndex = 0;

  void _onTappedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _Pages = [
    Acceuil(),
    MesFavoris(),
    AddSalle(),
    MesSalles(),
    profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//-----------------bottom barre mt3 Propriétaire  --------------------------------
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.blue[300],
        enableFeedback: false,
        showUnselectedLabels: true,
        selectedItemColor: blueColor,
        currentIndex: _selectedIndex,
        onTap: _onTappedItem,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Acceuil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoiris',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box_rounded,
              size: 40,
              color: Colors.blue[800],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.meeting_room),
            label: 'Mes Salles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
      body: _Pages[_selectedIndex],
    );
  }
}
