import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResultPage extends StatelessWidget {
  final List<DocumentSnapshot> results;

  const ResultPage({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Résultats de la recherche'),
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          
          Map<String, dynamic> salleData = results[index].data() as Map<String, dynamic>;

          return ListTile(
            title: Text(salleData['Nom']),
            subtitle: Text(salleData['adresse']),
            trailing: Text('${salleData['price']} DT/h'),
            onTap: () {
             
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(salleData: salleData),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final Map<String, dynamic> salleData;

  const DetailsPage({Key? key, required this.salleData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(salleData['Nom']),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Adresse: ${salleData['adresse']}'),
            SizedBox(height: 16),
            Text('Type: ${salleData['type']}'),
            SizedBox(height: 16),
            Text('Heure d\'ouverture: ${salleData['startTime']}'),
            SizedBox(height: 16),
            Text('Heure de fermeture: ${salleData['endTime']}'),
            SizedBox(height: 16),
            Text('Prix: ${salleData['price']} DT/h'),
            SizedBox(height: 16),
            Text('Équipements:'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (salleData['equipments'] as Map<String, dynamic>)
                  .entries
                  .map((entry) {
                if (entry.value == true) {
                  return Text(entry.key);
                }
                return SizedBox.shrink();
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
