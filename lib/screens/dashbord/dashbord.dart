import 'package:flutter/material.dart';
import 'package:reserviov1/screens/dashbord/UsernonVerifier.dart';
import 'package:reserviov1/screens/dashbord/userManagment.dart';
import 'package:reserviov1/widgets/dashbordAfficheCard.dart';



class DashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tableau de bord administratif'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Gestion des utilisateurs'),
              onTap: () {
                Navigator.pop(context); 
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => usernonverifier(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Gestion des salles'),
              onTap: () {
                Navigator.pop(context); 
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoomsManagementScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardInfo(
              
              
              title: 'Total des salles',
               
              onTap: () {
                // Afficher la liste des salles
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoomListScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            CardInfo(
              
             
              title: 'Total des utilisateurs',
                // Nombre total d'utilisateurs
              onTap: () {
                // Afficher la liste des utilisateurs
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UsersManagementScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}





class RoomsManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion des salles'),
      ),
      body: Center(
        child: Text('Ecran de gestion des salles'),
      ),
    );
  }
}

class RoomListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des salles'),
      ),
      body: ListView.builder(
        itemCount: 5, 
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Salle ${index + 1}'),
           subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID: ${index + 1}'),
                Text('Localisation: ${index + 1}'),
                Text('Heure de début: ${index + 1}'),
                Text('Heure de fin: ${index + 1}'),
                Text('Prix:  ${index + 1}'),
                Text('État:  ${index + 1}'),
                Text('Évaluation: ${index + 1}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des utilisateurs'),
      ),
      body: ListView.builder(
        itemCount: 10, 
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Utilisateur ${index + 1}'),
            subtitle: Text('Email: user${index + 1}@example.com'),
          );
        },
      ),
    );
  }
}


