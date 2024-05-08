import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';
import 'package:reserviov1/constants/constants.dart';
import 'package:reserviov1/screens/Notification.dart';
import 'package:reserviov1/screens/espaces%20details/SalleInfo.dart';
import 'package:reserviov1/screens/features/bot/chatbotT.dart';
import 'package:reserviov1/screens/profile/profile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reserviov1/widgets/horizCard.dart';
import 'package:reserviov1/screens/features/allSpaces/tousSalles.dart';
import 'package:reserviov1/widgets/Hcard.dart';
import 'package:reserviov1/widgets/cards.dart';
import 'package:reserviov1/widgets/reserviotophome.dart';

import '../../widgets/HoriCard.dart';

class Acceuil extends StatefulWidget {
  @override
  State<Acceuil> createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  Widget buildInfosWidget(AsyncSnapshot<QuerySnapshot> snapshot) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Infos(
        nbrSalle: snapshot.data!.docs.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String? userId = UserProfile.userId;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Acceuil'),
        actions: [
          // partie icone nofication
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notif()),
              );
            },
            icon: Icon(Icons.notifications_none_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('salles')
              .where('verifier', isEqualTo: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            // lehne thot ken mafama hata salle mawjouda
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('Aucune salle trouvée.'));
            }
            //hedi partie ely traja3lek el acceuil page
            List<QueryDocumentSnapshot> firstSpaces =
                snapshot.data!.docs.take(10).toList();

            //partie premiere conteneur ely feha count lel les salle w ktiba
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildInfosWidget(snapshot),
                // HorizCard(),

//-------------------------Debut conteneur 2------------------------------------------------
                //partie ely feha el alwen w size w decoration
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    width: width,
                    height: 100,
                    decoration: ShapeDecoration(
                      color: blueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    //lehne tabda partie el contenu ely fi west container 2
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //hedi fonction njib beha el username
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('user')
                                .doc(userId)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                              //hedi loading
                              if (userSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              //erreur
                              if (!userSnapshot.hasData ||
                                  !userSnapshot.data!.exists) {
                                return Text('Erreur: Utilisateur non trouvé');
                              }

                              //w hedi traja3li el username
                              String userName = userSnapshot.data!['username'];
                              //lehne el contenu mt3 el container
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                //hedi row feha text  button
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //partie text
                                    Text(
                                      "Salut $userName ,comment \npuis-je t'aider aujourd'hui ?",
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    //partie button
                                    FloatingActionButton(
                                      onPressed: () {
                                        //yhezk el page chatbot
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChatScreen()),
                                        );
                                      },
                                      backgroundColor: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        Icons.chat,
                                        color: blueColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
//------------------------------Fin containeur 2------------------------------------------------

//------------------------------ debut partie ely feha el cards 1---------------------------------------
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                  //hedi row feha titre + voir plus thezek el tous les salles
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tous les Espaces ',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          color: darkblue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ToutesLesSalles()));
                          },
                          child: Text('voir plus', style: SeeMoreStyle))
                    ],
                  ),
                ),
                //hedi partie ely feha el cards horizontale
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      //hedi map feha 8 premeir salles
                      children: firstSpaces.map((doc) {
                        String isdispo = doc['etat'];
                        String salleId = doc.id;
                        List<dynamic>? dynamicImageUrls = doc['imageUrls'];
                        List<String>? imageUrls = dynamicImageUrls
                            ?.map((url) => url.toString())
                            .toList();
                        String? premierImageUrl = imageUrls?.isNotEmpty ?? false
                            ? imageUrls![0]
                            : null;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                          ),
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SalleInfo(salleId),
                              ),
                            ),

                            //w hedi el card w el contenu mte3ha mes lena bc tbadel design
                            child: SizedBox(
                              child: CardsHome(
                                title: doc['Nom'],
                                location: doc['adresse'],
                                price: doc["price"].toString(),
                                imageUrl: premierImageUrl!,
                                availability: isdispo,
                              ),

                              // width: 150,
                              // child: FillImageCard(
                              //   width: 150,
                              //   heightImage: 150,
                              //   color: Colors.grey.shade200,
                              //   imageProvider: NetworkImage(premierImageUrl!),
                              //   //titre fih nom
                              //   title: Text(
                              //     doc['Nom'],
                              //     style: GoogleFonts.roboto(
                              //       fontSize: 16,
                              //       fontWeight: FontWeight.w600,
                              //       color: Colors.black87,
                              //     ),
                              //   ),
                              //   //description feha colum feha b9eyt les info
                              //   description: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text(
                              //         doc['adresse'],
                              //         style: GoogleFonts.roboto(
                              //           fontSize: 14,
                              //         ),
                              //       ),
                              //       Text(
                              //         doc['type'],
                              //         style: GoogleFonts.roboto(
                              //           fontSize: 14,
                              //         ),
                              //       ),
                              //       Text(
                              //         doc['price'].toString() + ' dt/h ',
                              //         style: GoogleFonts.roboto(
                              //           fontSize: 14,
                              //         ),
                              //       ),
                              //       if (isdispo == 'disponible')
                              //         Text(
                              //           ' disponible ',
                              //           style: GoogleFonts.roboto(
                              //             fontSize: 14,
                              //             color: Colors.green,
                              //           ),
                              //         ),
                              //       if (isdispo == 'Non disponible')
                              //         Text(
                              //           ' Non disponible ',
                              //           style: GoogleFonts.roboto(
                              //             fontSize: 14,
                              //             color: Colors.red,
                              //           ),
                              //         ),
                              //     ],
                              //   ),
                              // ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
//------------------------------Fin partie ely feha el cards 1---------------------------------------

//------------------------------Debut partie ely feha el cards 2(top rated)---------------------------------------
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                  //titre
                  child: Text(
                    'Top 10 Rated Espaces',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      color: darkblue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                //hedi function njib les salles bel rating desc
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('salles')
                      .orderBy('rating', descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('Aucun espace noté trouvé.'));
                    }

                    //hedi lista nhot feha el 10 sallet loulenin
                    List<QueryDocumentSnapshot> topSpaces =
                        snapshot.data!.docs.take(10).toList();
                    return SingleChildScrollView(
                      child: Column(
                        children: topSpaces.map((doc) {
                          String isdispo = doc['etat'];
                          String salleId = doc.id;

                          List<dynamic>? dynamicImageUrls = doc['imageUrls'];
                          List<String>? imageUrls = dynamicImageUrls
                              ?.map((url) => url.toString())
                              .toList();
                          String? premierImageUrl =
                              imageUrls?.isNotEmpty ?? false
                                  ? imageUrls![0]
                                  : null;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SalleInfo(salleId),
                                ),
                              ),

                              //w lehne design el cards mte3hom
                              child: CardTest(
                                  title: doc['Nom'],
                                  location: doc['adresse'],
                                  price: doc["price"].toString(),
                                  imageUrl: premierImageUrl!,
                                  rating: doc['rating'].toString()),
                              // child: SizedBox(
                              //   width: 150,
                              //   child: FillImageCard(
                              //     width: 150,
                              //     heightImage: 150,
                              //     color: Colors.grey.shade200,
                              //     imageProvider: NetworkImage(premierImageUrl!),
                              //     title: Text(
                              //       doc['Nom'],
                              //       style: GoogleFonts.roboto(
                              //         fontSize: 16,
                              //         fontWeight: FontWeight.w600,
                              //         color: Colors.black87,
                              //       ),
                              //     ),
                              //     description: Column(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       children: [
                              //         Text(
                              //           doc['adresse'],
                              //           style: GoogleFonts.roboto(
                              //             fontSize: 14,
                              //           ),
                              //         ),
                              //         Text(
                              //           doc['type'],
                              //           style: GoogleFonts.roboto(
                              //             fontSize: 14,
                              //           ),
                              //         ),
                              //         Text(
                              //           doc['price'].toString() + ' dt/h ',
                              //           style: GoogleFonts.roboto(
                              //             fontSize: 14,
                              //           ),
                              //         ),
                              //         if (isdispo == 'disponible')
                              //           Text(
                              //             ' disponible ',
                              //             style: GoogleFonts.roboto(
                              //               fontSize: 14,
                              //               color: Colors.green,
                              //             ),
                              //           ),
                              //         if (isdispo == 'Non disponible')
                              //           Text(
                              //             ' Non disponible ',
                              //             style: GoogleFonts.roboto(
                              //               fontSize: 14,
                              //               color: Colors.red,
                              //             ),
                              //           ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ),
                          );
                        }).toList(),
                      ),
                    );

                    //------------------------------Fin partie ely feha el cards 2---------------------------------------
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
