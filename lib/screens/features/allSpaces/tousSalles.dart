import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reserviov1/constants/constants.dart';
import 'package:reserviov1/screens/espaces%20details/SalleInfo.dart';


class ToutesLesSalles extends StatefulWidget {
  @override
  _ToutesLesSallesState createState() => _ToutesLesSallesState();
}

class _ToutesLesSallesState extends State<ToutesLesSalles> {
  //partie declaration
  late String searchText = '';
  late List<QueryDocumentSnapshot> allSpaces = [];
  late List<QueryDocumentSnapshot> filteredSpaces = [];
  String selectedType = 'Tous'; //salet lkol par defaut

  @override
  void initState() {
    super.initState();
    fetchSpaces();
  }
 //salle a afficher
  Future<void> fetchSpaces() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('salles').where('verifier', isEqualTo: true).get();
    setState(() {
      allSpaces = snapshot.docs;
      filteredSpaces = List.from(allSpaces);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toutes les salles'),
        //icone recherche
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final String? result = await showSearch<String>(
                context: context,
                delegate: _CustomSearchDelegate(allSpaces),
              );
              if (result != null) {
                setState(() {
                  searchText = result;
                });
              }
            },
          ),
        
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
//----------------partie de choix de type de salle a afficher -----------------------------------
            child: Row(
              children: [
                //build widget tal9aha louta 
                SizedBox(width: 10),
                buildTypeButton('Tous'),
                buildTypeButton('Salle événement'),
                buildTypeButton('Bureau'),
                buildTypeButton('Salle de réunion'),
                buildTypeButton('Salle de conférence'),
                buildTypeButton('Salle de projection'),
                buildTypeButton('Salle d\'exposition'),
               
                SizedBox(width: 10),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSpaces.length,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot doc = filteredSpaces[index];
                String isdispo = doc['etat'];
                String salleId = doc.id;
                List<dynamic>? dynamicImageUrls = doc['imageUrls'];
                List<String>? imageUrls =
                    dynamicImageUrls?.map((url) => url.toString()).toList();
                String? premierImageUrl =
                    imageUrls?.isNotEmpty ?? false ? imageUrls![0] : null;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SalleInfo(salleId),
                      ),
                    ),
//------------------------------Partie card des salles---------------------------------
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            child: premierImageUrl != null
                                ? Image.network(
                                    premierImageUrl,
                                    fit: BoxFit.cover,
                                    width: 400,
                                    height: 150,
                                  )
                                : Container(
                                    color: Colors.grey,
                                    height: 150,
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doc['Nom'],
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  doc['adresse'],
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  doc['type'],
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  doc['price'].toString() + ' dt/h ',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                  ),
                                ),
                                if (isdispo == 'disponible')
                                  Text(
                                    ' disponible ',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: Colors.green,
                                    ),
                                  ),
                                if (isdispo == 'Non disponible')
                                  Text(
                                    ' Non disponible ',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: Colors.red,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
//-------------------------------Fin Partie reserver button-----------------------------------                    
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
//partie type de salle 
  Widget buildTypeButton(String type) {
    bool isSelected = selectedType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedType = type;
          filteredSpaces = type == 'Tous'
              ? List.from(allSpaces)
              : allSpaces.where((doc) => doc['type'] == type).toList();
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? blueColor : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              type,
              style: TextStyle(
                color: isSelected ? Colors.white : null,
                fontWeight: isSelected ? FontWeight.bold : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//---------------------------------partiesearch ---------------------------------------------
class _CustomSearchDelegate extends SearchDelegate<String> {
  final List<QueryDocumentSnapshot> allSpaces;

  _CustomSearchDelegate(this.allSpaces);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }
//resultat 
  @override
  Widget buildResults(BuildContext context) {
    final List<QueryDocumentSnapshot> searchResults = allSpaces.where((doc) {
      String nomSalle = doc['Nom'].toString().toLowerCase();
      String adresseSalle = doc['adresse'].toString().toLowerCase();
      return nomSalle.contains(query.toLowerCase()) || adresseSalle.contains(query.toLowerCase());
    }).toList();
   //return list des salles 
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        QueryDocumentSnapshot doc = searchResults[index];
        String isdispo = doc['etat'];
        String salleId = doc.id;
        List<dynamic>? dynamicImageUrls = doc['imageUrls'];
        List<String>? imageUrls = dynamicImageUrls?.map((url) => url.toString()).toList();
        String? premierImageUrl = imageUrls?.isNotEmpty ?? false ? imageUrls![0] : null;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SalleInfo(salleId),
              ),
            ),
//---------------------------------partie card filtres----------------------------------
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: premierImageUrl != null
                        ? Image.network(
                            premierImageUrl,
                            fit: BoxFit.cover,
                            width: 400,
                            height: 150,
                          )
                        : Container(
                            color: Colors.grey,
                            height: 150,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doc['Nom'],
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          doc['adresse'],
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          doc['type'],
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          doc['price'].toString() + ' dt/h ',
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                          ),
                        ),
                        if (isdispo == 'disponible')
                          Text(
                            ' disponible ',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          ),
                        if (isdispo == 'Non disponible')
                          Text(
                            ' Non disponible ',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: Colors.red,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
//---------------------------------partie card filtres----------------------------------            
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView();
  }
}
