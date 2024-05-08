

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reserviov1/screens/Login/firebaseAuth/FirebaseAuthServices.dart';
import 'package:reserviov1/screens/espaces%20details/SalleInfo.dart';
import 'package:reserviov1/screens/profile/profile.dart';
import 'package:image_card/image_card.dart';

class MesSalles extends StatefulWidget {
  const MesSalles({Key? key}) : super(key: key);

  @override
  State<MesSalles> createState() => _MesSallesState();
}

class _MesSallesState extends State<MesSalles> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  

  @override
  Widget build(BuildContext context) {
    String? userId = UserProfile.userId;
    

    return Scaffold(
      appBar: AppBar(title: Text('Mes salles')),
      body: StreamBuilder(
        //njib fel les salles mt3 el user mel base 
        stream: FirebaseFirestore.instance.collection('salles').where('owner', isEqualTo: userId).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            //loading
            return Center(child: CircularProgressIndicator());
          }
           //mafamech salles
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Aucune salle trouvée.'));
          }
           //return ken 3andou des salles
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              bool isVerified = doc['verifier'] ?? false;
               String isdispo = doc['etat'] ;
               String salleId = doc.id ;
                List<dynamic>? dynamicImageUrls = doc['imageUrls'];
List<String>? imageUrls = dynamicImageUrls?.map((url) => url.toString()).toList();
                 String? premierImageUrl = imageUrls?.isNotEmpty ?? false ? imageUrls![0] : null;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
                child: GestureDetector(
                  onTap:()=>   Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SalleInfo(salleId),
                ),
              ),

//----------------------Debut paritie card ---------------------------------
                  child: FillImageCard(
                    width: 500,
                    heightImage: 200,
                   color : Colors.grey.shade200,
                    imageProvider: NetworkImage(premierImageUrl!),
                    //titre fih nom
                    title: Text(
                      doc['Nom'],
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      
                    ),
                    //description
                    description: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doc['adresse'],
                          style: GoogleFonts.roboto(
                            
                            fontSize: 16,
                          ),
                        ),
                         Text(
                          doc['type'],
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                          ),
                        ),
                        
                        Text(
                          'Prix : ' + doc['price'].toString() + ' dt/h ',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                          ),
                          
                        ),
                        if (isdispo == 'disponible')
                         Text(
                          'etat : disponible ' ,
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: Colors.green
                  
                          ),
                          
                    
                        ),
                        if (isdispo == 'Non disponible')
                         Text(
                          'etat : Non disponible ' ,
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: Colors.red
                  
                          ),),
                        Text(
                          
                          isVerified ? 'Vérifié' : 'Non vérifié',
                          style: TextStyle(
                            color: isVerified ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          
                          ),
                          
                        ),
                       
                        
                      ],
                    ),
                  ),
//---------------------Fin partie card ---------------------------------
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
