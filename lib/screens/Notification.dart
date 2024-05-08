import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reserviov1/constants/constants.dart';
import 'package:reserviov1/screens/conversation.dart';
import 'package:reserviov1/screens/profile/profile.dart';

class Notif extends StatefulWidget {
  const Notif({super.key});

  @override
  State<Notif> createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  void deletereservation(String docId) async {
    await FirebaseFirestore.instance
        .collection('reservation')
        .doc(docId)
        .delete();
  }

  void addReservationToHistory(
      String salleId,
      String nom,
      String adresse,
      String startTime,
      String endTime,
      String price,
      String client,
      String day,
      String owner,
      String etat,
      double rating) async {
    await FirebaseFirestore.instance.collection("historique").add({
      'salleId': salleId,
      'nom': nom,
      'adresse': adresse,
      'startTime': startTime,
      'endTime': endTime,
      'price': price,
      'client': client,
      'day': day,
      'owner': owner,
      'etat': etat,
      'rating': rating,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  void acceptreservation(String docId, String etat) {
    FirebaseFirestore.instance.collection('reservation').doc(docId).update({
      'etat': etat,
    });
  }

  void etatSalle(String docId, etat) {
    FirebaseFirestore.instance.collection('salles').doc(docId).update({
      'etat': etat,
    });
  }

  @override
  Widget build(BuildContext context) {
    String? userId = UserProfile.userId;
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('reservation').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              //loading
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              //error
              return Text('Error: ${snapshot.error}');
            } else {
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                //nsob fel les donner mte3i
                List<Widget> reservationsWidgets = [];
                for (var document in snapshot.data!.docs) {
                  var ReservationData = document.data() as Map<String, dynamic>;
                  String nom = ReservationData['Nom'];
                  String adresse = ReservationData['adresse'];
                  String salle = ReservationData['salleid'];
                  String etat = ReservationData['etat'];
                  String owner = ReservationData['owner'];
                  String client = ReservationData['client'];
                  String start =
                      '${ReservationData['startTime']?.toStringAsFixed(0)}:00';
                  String date = ReservationData['date'];
                  String end =
                      '${ReservationData['endTime']?.toStringAsFixed(0)}:00';

                  String price = ReservationData['price'];
                  String day = ReservationData['day'];
                  List<dynamic> conversation =
                      ReservationData["conversation"] ?? [];

//+++++++++++++++++++++++++++++partie owner++++++++++++++++++++++++++++++++++++++++++++++++++++

//----------------------------partie owner + en attend--------------------------------------------

                  if (owner == userId && etat == 'en attente') {
                    reservationsWidgets.add(
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('user')
                            .doc(client)
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                          if (userSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }

                          if (!userSnapshot.hasData ||
                              !userSnapshot.data!.exists) {
                            return Text('Erreur: Utilisateur non trouvé');
                          }

                          String userName = userSnapshot.data!['username'];
                          return GestureDetector(
                            onTap: () {
                              //show dialogue feha el recapitualtif  de la reservation
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                        'Récapitulatif de la réservation de $userName'),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          //contenu
                                          Text('Nom de la salle : $nom'),
                                          SizedBox(height: 10),
                                          Text('Adresse : $adresse'),
                                          SizedBox(height: 10),
                                          Text('Jour sélectionné : $day'),
                                          SizedBox(height: 10),
                                          Text('Jour sélectionné : $date'),
                                          SizedBox(height: 10),
                                          Text('Heure de début : $start'),
                                          SizedBox(height: 10),
                                          Text('Heure de fin : $end'),
                                          SizedBox(height: 10),
                                          Text('Prix total : $price'),
                                        ],
                                      ),
                                    ),
                                    //les fonction accept w refuser
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          acceptreservation(
                                              document.id, 'refuser');
                                          Navigator.pop(context);
                                        },
                                        child: Text('Refuser'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          acceptreservation(
                                              document.id, 'accepter');
                                          etatSalle(salle, 'Non disponible');
                                          Navigator.pop(context);
                                        },
                                        child: Text('Confirmer'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            //-------------heda el container ely fih design en attend ------------------------

                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "le client $userName veut reserver votre salle  $nom le $day le $date de $start a $end",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),

//-------------Fin container ely fih design en attend ---------------------------------
                          );
                        },
                      ),
                    );
                  }

//----------------------------------partie owner + accepter----------------------------
                  if (owner == userId && etat == 'accepter') {
                    reservationsWidgets.add(
                      Stack(
                        children: [
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('user')
                                .doc(client)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                              if (userSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }

                              if (!userSnapshot.hasData ||
                                  !userSnapshot.data!.exists) {
                                return Text('Erreur: Utilisateur non trouvé');
                              }

                              String userName = userSnapshot.data!['username'];
                              return GestureDetector(
                                onTap: () {
                                  //showdialog feha recap reservation
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                            'Récapitulatif de la réservation de $userName'),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text('Nom de la salle : $nom'),
                                              SizedBox(height: 10),
                                              Text('Adresse : $adresse'),
                                              SizedBox(height: 10),
                                              Text('Jour sélectionné : $day'),
                                              SizedBox(height: 10),
                                              Text('Jour sélectionné : $date'),
                                              SizedBox(height: 10),
                                              Text('Heure de début : $start'),
                                              SizedBox(height: 10),
                                              Text('Heure de fin : $end'),
                                              SizedBox(height: 10),
                                              Text('Prix total : $price'),
                                            ],
                                          ),
                                        ),

                                        //fermer action
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Fermer'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },

//-------------Debut container ely fih design accepter ---------------------------------

                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: blueColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "vous avez accepter la reservation de $userName pour la salle  $nom le $day le $date de $start a $end",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 55,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          //heda partie feha button ely y7elk el convertation
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                                margin: EdgeInsets.only(right: 15, bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: TextButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ConversationPage(
                                            currentUser: userId!,
                                            reservationId: document.id,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.chat_bubble_outline),
                                    label: Text('ouvrir conversation'))),
                            //-------------Fin container ely fih design accepter ---------------------------------
                          ),
                        ],
                      ),
                    );
                  }

//+++++++++++++++++++++++++++++++++++++Partie Client++++++++++++++++++++++++++++++++

//-------------------------------- client + en attend -------------------------------

                  if (client == userId && etat == 'en attente') {
                    reservationsWidgets.add(
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('user')
                            .doc(owner)
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                          if (userSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }

                          if (!userSnapshot.hasData ||
                              !userSnapshot.data!.exists) {
                            return Text('Erreur: Utilisateur non trouvé');
                          }

                          String userName = userSnapshot.data!['username'];
                          return GestureDetector(
                            onTap: () {
                              //showdialog recap reservation

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                        'Récapitulatif de votre réservation '),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('Nom de la salle : $nom'),
                                          SizedBox(height: 10),
                                          Text('Adresse : $adresse'),
                                          SizedBox(height: 10),
                                          Text('Jour sélectionné : $day'),
                                          SizedBox(height: 10),
                                          Text('Jour sélectionné : $date'),
                                          SizedBox(height: 10),
                                          Text('Heure de début : $start'),
                                          SizedBox(height: 10),
                                          Text('Heure de fin : $end'),
                                          SizedBox(height: 10),
                                          Text('Prix total : $price'),
                                        ],
                                      ),
                                    ),
                                    //lena el client ya3mel annuller lel reservation
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          deletereservation(document.id);
                                          Navigator.pop(context);
                                        },
                                        child: Text('annuler la reservation'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
//-------------Fin container ely fih design en attend Client  ---------------------------------
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "En attend de la reponse de $userName le propriétaire de la salle  $nom que tu veut le reserver le $day le $date de $start a $end",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),

//-------------Fin container ely fih design en attend Client ---------------------------------
                          );
                        },
                      ),
                    );
                  }

//---------------Partie Client refuser ----------------------------------------------------

                  if (client == userId && etat == 'refuser') {
                    reservationsWidgets.add(
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('user')
                            .doc(owner)
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                          if (userSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }

                          if (!userSnapshot.hasData ||
                              !userSnapshot.data!.exists) {
                            return Text('Erreur: Utilisateur non trouvé');
                          }

                          String userName = userSnapshot.data!['username'];
                          return GestureDetector(
                            onTap: () {
                              //show dialog fih recap reservation
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                        'Récapitulatif de votre réservation '),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('Nom de la salle : $nom'),
                                          SizedBox(height: 10),
                                          Text('Adresse : $adresse'),
                                          SizedBox(height: 10),
                                          Text('Jour sélectionné : $day'),
                                          SizedBox(height: 10),
                                          Text('Jour sélectionné : $date'),
                                          SizedBox(height: 10),
                                          Text('Heure de début : $start'),
                                          SizedBox(height: 10),
                                          Text('Heure de fin : $end'),
                                          SizedBox(height: 10),
                                          Text('Prix total : $price'),
                                        ],
                                      ),
                                    ),

                                    //lehne yfasa5 el resrvation mel notif
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          deletereservation(document.id);
                                        },
                                        child: Text('supprimer la reservation'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },

//---------------Partie Container refuser ----------------------------------------------------

                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "le proprietaire $userName a refuser voter reservation de la salle  $nom le $day le $date de $start a $end",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
//-------------------------Fin container lena-----------------------------------------
                          );
                        },
                      ),
                    );
                  }

//----------------------------------client + accepter-----------------------------------

                  if (client == userId && etat == 'accepter') {
                    reservationsWidgets.add(
                      Stack(
                        children: [
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('user')
                                .doc(owner)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                              if (userSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }

                              if (!userSnapshot.hasData ||
                                  !userSnapshot.data!.exists) {
                                return Text('Erreur: Utilisateur non trouvé');
                              }

                              String userName = userSnapshot.data!['username'];
                              return GestureDetector(
                                onTap: () {
                                  double currentRating = 0;
                                  double userRating = 0;
                                  double combinedRating = 0;
                                  //showdialog recap reservation
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                            'Récapitulatif de votre réservation'),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text('Nom de la salle : $nom'),
                                              SizedBox(height: 10),
                                              Text('Adresse : $adresse'),
                                              SizedBox(height: 10),
                                              Text('Jour sélectionné : $day'),
                                              SizedBox(height: 10),
                                              Text('Jour sélectionné : $date'),
                                              SizedBox(height: 10),
                                              Text('Heure de début : $start'),
                                              SizedBox(height: 10),
                                              Text('Heure de fin : $end'),
                                              SizedBox(height: 10),
                                              Text('Prix total : $price'),
                                            ],
                                          ),
                                        ),
                                        //action ki tkamel reservation tenzel terminer
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () async {
                                              //show rating hedi widget feha rating tal9aha louta belkol
                                              showRatingDialog(
                                                  document.id,
                                                  salle,
                                                  nom,
                                                  adresse,
                                                  start,
                                                  end,
                                                  price,
                                                  client,
                                                  day,
                                                  owner,
                                                  etat);
                                              etatSalle(salle, 'disponible');
                                            },
                                            child: Text('Réservation terminée'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Fermer'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },

//---------------------container ely fih el contenu accepter client ------------------------
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: blueColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "le proprietaire $userName a accepter votre reservation a la salle  $nom le $day le $date de $start a $end",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          //button convercation
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                                margin: EdgeInsets.only(right: 15, bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: TextButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ConversationPage(
                                            reservationId: document.id,
                                            currentUser: userId!,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.chat_bubble_outline),
                                    label: Text('ouvrir conversation'))),
                          ),
                        ],
                      ),
                    );
                  }
                }
                return Column(
                  children: reservationsWidgets,
                );
              } else {
                //partie pas des notifications
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/empty.svg"),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: Text(
                        "Pas de notification",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: darkblue)),
                      ))
                    ],
                  ),
                );
                ;
              }
            }
          },
        ),
      ),
    );
  }

//------------------------------------ rating widget----------------------------------------------
  void showRatingDialog(
      String docId,
      String salleId,
      String nom,
      String adresse,
      String start,
      String end,
      String price,
      String client,
      String day,
      String owner,
      String etat) {
    double userRating = 0;
    //show dialog feha text w njoum
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Donner une note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Donnez une note à cette salle:'),
              SizedBox(height: 10),
              RatingBar.builder(
                initialRating: userRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 40,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (value) {
                  userRating = value;
                },
              ),
            ],
          ),
          //les action ely ysirou ki nenzel skip wella rating tajouti el reservation lel historique w tfasa5ha mel reservation w ken 3malt rating tzidou lel salla
          actions: <Widget>[
            TextButton(
              onPressed: () {
                //add to his
                addReservationToHistory(
                    salleId,
                    nom,
                    adresse,
                    start,
                    end,
                    price,
                    client,
                    day,
                    owner,
                    etat,
                    userRating > 0 ? userRating : 0);
                //delete res
                deletereservation(docId);
                Navigator.pop(context);
              },
              child: Text('Skip'),
            ),
            //add rating
            TextButton(
              onPressed: () async {
                DocumentSnapshot salleSnapshot = await FirebaseFirestore
                    .instance
                    .collection('salles')
                    .doc(salleId)
                    .get();
                if (salleSnapshot.exists) {
                  Map<String, dynamic>? salleData =
                      salleSnapshot.data() as Map<String, dynamic>?;
                  double currentRating = salleData?['rating'] ?? 0;
                  double combinedRating = (currentRating + userRating) / 2;
                  await FirebaseFirestore.instance
                      .collection('salles')
                      .doc(salleId)
                      .update({
                    'rating': combinedRating,
                  });
                  addReservationToHistory(
                      salleId,
                      nom,
                      adresse,
                      start,
                      end,
                      price,
                      client,
                      day,
                      owner,
                      etat,
                      userRating > 0 ? userRating : 0);
                  deletereservation(docId);
                  Navigator.pop(context);
                } else {
                  print('Salle not found in Firestore.');
                }
              },
              child: Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }
}
