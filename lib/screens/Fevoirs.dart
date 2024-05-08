import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reserviov1/screens/Login/firebaseAuth/FirebaseAuthServices.dart';
import 'package:reserviov1/screens/espaces%20details/SalleInfo.dart';
import 'package:reserviov1/screens/profile/profile.dart';
import 'package:image_card/image_card.dart';

class MesFavoris extends StatefulWidget {
  const MesFavoris({Key? key}) : super(key: key);

  @override
  State<MesFavoris> createState() => _MesFavorisState();
}

class _MesFavorisState extends State<MesFavoris> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  

  @override
  Widget build(BuildContext context) {
    String? userId = UserProfile.userId;

    return Scaffold(
      appBar: AppBar(title: Text('Mes favoris')),
      body: StreamBuilder(
        //njib fil favoris mt3 user mel firebase
        stream: FirebaseFirestore.instance
            .collection('Favoris')
            .where('owner', isEqualTo: userId)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //loading lena
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          //keni fergha traja3 hedi
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Aucun favori trouvé.'));
          }
          //lenhe traja3lek el cards favori ken 3andek
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('salles')
                    .doc(doc['Salle'])
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> salleSnapshot) {
                  if (salleSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return SizedBox();
                  }
                  if (!salleSnapshot.hasData ||
                      !salleSnapshot.data!.exists) {
                    return SizedBox(); 
                  } 

                  //nsob fel data lena 

                  var salleData =
                      salleSnapshot.data!.data() as Map<String, dynamic>;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SalleInfo(doc['Salle']),
                        ),
                      ),
//-------------- Debut partie design card tebda mena ------------------------------------ 
                      child: FillImageCard(
                        width: 500,
                        heightImage: 200,
                        color: Colors.grey.shade200,
                        imageProvider:
                              NetworkImage(
                            (salleData['imageUrls'] as List<dynamic>)
                                .first),

                        title: Text(
                          salleData['Nom'],
                          style: GoogleFonts.roboto(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        description: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              salleData['adresse'],
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              salleData['type'],
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Prix : ' +
                                  salleData['price']
                                      .toString() +
                                  ' dt/h ',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              salleData['etat'] == 'disponible'
                                  ? 'État : disponible '
                                  : 'État : Non disponible ',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                color: salleData['etat'] ==
                                        'disponible'
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),


//-------------- Fin partie design card toufaa lena ------------------------------------ 


                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
