import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reserviov1/constants/constants.dart';
import 'package:reserviov1/screens/Login/firebaseAuth/FirebaseAuthServices.dart';
import 'package:reserviov1/screens/features/prop/ModifySalle.dart';
import 'package:reserviov1/screens/features/SimpleUser/ReservationSalle.dart';
import 'package:reserviov1/screens/profile/profile.dart';
import 'package:reserviov1/widgets/AffichageEquipements.dart';
import 'package:reserviov1/widgets/showImage.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart' as LatLng;

enum BadgeLevel {
  bronze,
  silver,
  gold,
  diamond,
}

class SalleInfo extends StatefulWidget {
  final String salleId;

  SalleInfo(this.salleId);

  @override
  State<SalleInfo> createState() => _SalleInfoState();
}

class _SalleInfoState extends State<SalleInfo> {
  String? userId = UserProfile.userId;
  late bool _enableButton;
  BadgeLevel _badgeLevel = BadgeLevel.bronze;
  late bool isFavorited = false;
  final TextEditingController commentController = TextEditingController();
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  bool showLocation = false;

  void toggleLocation() {
    setState(() {
      showLocation = !showLocation;
    });
  }

  Future<void> addfavoires(String owner, String salle) async {
    await FirebaseFirestore.instance.collection("Favoris").add({
      'owner': owner,
      'Salle': salle,
    });
  }

  Future<void> deleteSalle(String salleId) async {
    try {
      await FirebaseFirestore.instance
          .collection("salles")
          .doc(salleId)
          .delete();
      print("La salle a été supprimée avec succès.");
    } catch (error) {
      print("Erreur lors de la suppression de la salle : $error");
    }
  }

  Future<void> deleteFavoris(String owner, String salle) async {
    QuerySnapshot favorisSnapshot = await FirebaseFirestore.instance
        .collection("Favoris")
        .where('owner', isEqualTo: owner)
        .where('Salle', isEqualTo: salle)
        .get();

    favorisSnapshot.docs.forEach((document) {
      document.reference.delete();
    });
  }

  Future<String?> checkusername(String userId) async {
    try {
      final userSnapshot =
          await FirebaseFirestore.instance.collection("user").doc(userId).get();

      if (userSnapshot.exists) {
        final username = userSnapshot.data()?['username'];
        return username;
      } else {
        print("L'utilisateur avec l'ID $userId n'existe pas.");
        return null;
      }
    } catch (error) {
      print("Erreur lors de la récupération du nom d'utilisateur : $error");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    checkFavorite();
    _checkBadgeLevel();
  }

  Future<void> _checkBadgeLevel() async {
    var historiqueQuery = await FirebaseFirestore.instance
        .collection('historique')
        .where('owner', isEqualTo: userId)
        .get();
    var ownerCount = historiqueQuery.docs.length;

    historiqueQuery = await FirebaseFirestore.instance
        .collection('historique')
        .where('client', isEqualTo: userId)
        .get();
    var clientCount = historiqueQuery.docs.length;

    var totalCount = ownerCount + clientCount;
    print('Total count: $totalCount');
    if (totalCount >= 25) {
      _setBadgeLevel(BadgeLevel.diamond);
    } else if (totalCount >= 10) {
      _setBadgeLevel(BadgeLevel.gold);
    } else if (totalCount >= 5) {
      _setBadgeLevel(BadgeLevel.silver);
    } else {
      _setBadgeLevel(BadgeLevel.bronze);
    }
  }

  void _setBadgeLevel(BadgeLevel level) {
    print('Setting badge level to: $level');
    setState(() {
      _badgeLevel = level;
    });
  }

  Future<void> checkFavorite() async {
    String? userId = UserProfile.userId;

    if (userId != null) {
      await FirebaseFirestore.instance
          .collection("Favoris")
          .where('owner', isEqualTo: userId)
          .where('Salle', isEqualTo: widget.salleId)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          setState(() {
            isFavorited = true;
          });
        } else {
          setState(() {
            isFavorited = false;
          });
        }
      });
    }
  }

  Widget build(BuildContext context) {
    String? userId = UserProfile.userId;
    String? salleId = widget.salleId;
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la salle'),
      ),
      body: FutureBuilder (
        future: FirebaseFirestore.instance
            .collection('salles')
            .doc(widget.salleId)
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            //loading
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            //mafamech
            return Center(child: Text('La salle n\'existe pas.'));
          }
          //partie recup des donner
          var data = snapshot.data!.data() as Map<String, dynamic>;
          String jours = data['days'].toString();
          jours = jours.replaceAll('[', '');
          jours = jours.replaceAll(']', '');
          jours = jours.replaceAll(',', '');
          String isdispo = data['etat'];
          List<dynamic> imageUrls = data['imageUrls'] ?? [];

          bool hasWiFi =
              (data['equipments'] as Map<String, dynamic>).containsKey('Wifi');
          bool hasClimatiseur = (data['equipments'] as Map<String, dynamic>)
              .containsKey('Climatiseur');
          bool hasProjecteurs = (data['equipments'] as Map<String, dynamic>)
              .containsKey('Projecteurs');
          bool hasEcrans = (data['equipments'] as Map<String, dynamic>)
              .containsKey('Ecrans');
          bool hasSecurite = (data['equipments'] as Map<String, dynamic>)
              .containsKey('Système de sécurité');
          bool hasTableau = (data['equipments'] as Map<String, dynamic>)
              .containsKey('Tableau blanc');
          List<dynamic> commentaires = data['commentaires'] ?? [];

          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //----------------------- Partie image + icone heart ------------------------------------
                    Stack(
                      children: [
                        SizedBox(
                          height: 200,
                          //liste des images
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: imageUrls.length,
                            itemBuilder: (context, index) {
                              String imageUrl = imageUrls[index];
                              //t'affichi el image bel kbir
                              return GestureDetector(
                                onTap: () {
                                  showImageDialog(context, imageUrl);
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: Image.network(
                                    imageUrl,
                                    width: 400,
                                    height: 300,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        //partie icone heart
                        Positioned(
                          top: 10,
                          right: 15,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Color.fromRGBO(233, 233, 233, 0.5),
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isFavorited = !isFavorited;
                                    if (isFavorited) {
                                      addfavoires(
                                          UserProfile.userId!, widget.salleId);
                                    } else {
                                      deleteFavoris(
                                          UserProfile.userId!, widget.salleId);
                                    }
                                  });
                                },
                                icon: Icon(
                                  isFavorited
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color:
                                      isFavorited ? Colors.red : Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //----------------------------Fin partie image icone --------------------------

                    //-------------Partie info nom +adresse + type + rating ---------------------------

                    //row image + rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //nom
                        Text(
                          ' ${data['Nom']} ',
                          style: GoogleFonts.roboto(
                            fontSize: 24,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            //row icone +rating
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              Text(
                                ' ${data['rating']} ',
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    //adressee clicable affiche la localisation
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //show more
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showLocation = !showLocation;
                            });
                          },

                          //adresse
                          child: Text(' ${data['adresse']}',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                              )),
                        ),

                        //text more adresse copiable
                        if (showLocation)
                          GestureDetector(
                            onTap: () {
                              final coordinatesText =
                                  '[${data['location'].latitude}° ${data['location'].latitude > 0 ? 'N' : 'S'}, ${data['location'].longitude}° ${data['location'].longitude > 0 ? 'E' : 'W'}]';
                              Clipboard.setData(
                                  ClipboardData(text: coordinatesText));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Coordonnées copiées dans le presse-papiers'),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              //text de loc
                              child: Text(
                                'Cliquer ici pour copier ces coordonnées dans Maps pour trouver l\'exacte localisation: [${data['location'].latitude}° ${data['location'].latitude > 0 ? 'N' : 'S'}, ${data['location'].longitude}° ${data['location'].longitude > 0 ? 'E' : 'W'}]',
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      //type
                      child: Text(
                        '${data['type']}',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                    //--------------------------Fin Partie info nom +adresse + type + rating ---------------------------
                    SizedBox(height: 20),

//------------------------partie container disponibiliter horaire------------------------
                    Container(
                      width: 400,
                      height: 110,
                      margin: EdgeInsets.all(7),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        //row feha icone time + column feha titre days et time
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(Icons.timelapse_rounded, size: 45),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //titre
                              Text(
                                'Disponibiliter',
                                style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              //jours
                              Text(
                                '$jours',
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),

                              //time
                              //row starttime + endtime
                              Row(
                                children: [
                                  Text(
                                    'ouvre le ${data['startTime'].toStringAsFixed(0)}:00',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    ' et ferme le: ${data['endTime'].toStringAsFixed(0)}:00',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

//------------------------Fin partie container disponibiliter horaire------------------------

//------------------------partie equipements------------------------
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(Icons.event_seat_outlined),
                        ),

                        //titre
                        Text(
                          'Equipements',
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    //list des equipements
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Row(
                          children: [
                            //build equipements widget fil widgets
                            if ((data['equipments'] as Map<String, dynamic>)
                                    .containsKey('Wifi') &&
                                (data['equipments']['Wifi'] as bool))
                              buildEquipmentIcon('WiFi', Icons.wifi),
                            if ((data['equipments'] as Map<String, dynamic>)
                                    .containsKey('Climatiseur') &&
                                (data['equipments']['Climatiseur'] as bool))
                              buildEquipmentIcon(
                                  'Climatisation', Icons.ac_unit),
                            if ((data['equipments'] as Map<String, dynamic>)
                                    .containsKey('Projecteurs') &&
                                (data['equipments']['Projecteurs'] as bool))
                              buildEquipmentIcon(
                                  'Projection', Icons.video_label),
                            if ((data['equipments'] as Map<String, dynamic>)
                                    .containsKey('Ecrans') &&
                                (data['equipments']['Ecrans'] as bool))
                              buildEquipmentIcon('Ecrans', Icons.tv),
                            if ((data['equipments'] as Map<String, dynamic>)
                                    .containsKey('Tableau blanc') &&
                                (data['equipments']['Tableau blanc'] as bool))
                              buildEquipmentIcon(
                                  'Tableau', Icons.view_headline),
                            if ((data['equipments'] as Map<String, dynamic>)
                                    .containsKey('Système de sécurité') &&
                                (data['equipments']['Système de sécurité']
                                    as bool))
                              buildEquipmentIcon(
                                  'Système de sécurité', Icons.security),
                            buildEquipmentIcon(
                                '${data['bureaux']} bureau ', Icons.desk),
                            buildEquipmentIcon(
                                ' ${data['chaises']} chaise', Icons.chair),
                          ],
                        ),
                      ),
                    ),
                    //affichage disponibiliter mainetenant si dispo en vert et rouge si pas dispo

                    //dispo
                    if (isdispo == 'disponible')
                      Text.rich(
                          TextSpan(text: 'etat : ', children: <InlineSpan>[
                        TextSpan(
                          text: 'disponible',
                          style: GoogleFonts.roboto(
                              fontSize: 16, color: Colors.green),
                        )
                      ])),

                    //pas dispo now
                    if (isdispo == 'Non disponible')
                      Text.rich(
                          TextSpan(text: 'etat : ', children: <InlineSpan>[
                        TextSpan(
                          text: 'Non disponible Mainetenant',
                          style: GoogleFonts.roboto(
                              fontSize: 16, color: Colors.red),
                        ),
                      ])),
                    SizedBox(height: 16),

//------------------------partie comments------------------------
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.comment_rounded),
                        ),
                        //titre
                        Text(
                          'Commentaires',
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    //container de ajout de commentaire
                    Container(
                      height: 55,
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: commentController,
                              decoration: InputDecoration(
                                hintText: 'ajouter votre commentaire ceci',
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 5),
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          //icone envoyer
                          IconButton(
                            icon: Icon(Icons.send,
                                color: Color.fromARGB(255, 107, 99, 255)),
                            onPressed: () async {
                              if (commentController.text.isNotEmpty) {
                                String mycomment = commentController.text;
                                String? username = await checkusername(userId!);

                                FirebaseFirestore.instance
                                    .collection('salles')
                                    .doc(widget.salleId)
                                    .update({
                                  'commentaires': FieldValue.arrayUnion(
                                      ['$username  : $mycomment'])
                                }).then((value) {
                                  commentController.clear();
                                  setState(() {
                                    commentaires.add('$username  : $mycomment');
                                  });
                                }).catchError((error) {
                                  print(
                                      "Erreur lors de l'ajout du commentaire : $error");
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    //ajout de comment
                    if (commentaires.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: commentaires.length,
                        itemBuilder: (context, index) {
                          String commentaire = commentaires[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),

                            //design container commentaire
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  buildBadge(),
                                  SizedBox(width: 5),
                                  Text(commentaire),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    else
                      //si pas des commentaires
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Aucun commentaire.'),
                      ),
                    SizedBox(height: 90),
                  ],
                ),
              ),
              //------------------------Fin partie comments----------------------------

              //---------------------------Partie reserver button-------------------------
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 80,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //prix
                      Text(
                        '${data['price']} dt/h',
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      //row pour le prop pour modifier ou supp sa salle
                      Row(
                        children: [
                          if (userId == data['owner'])
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ModifySalle(widget.salleId),
                                  ),
                                );
                              },
                              icon: Icon(Icons.edit),
                            ),
                          if (userId == data['owner'])
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Confirmation"),
                                      content: Text(
                                          "Êtes-vous sûr de vouloir supprimer cette salle ?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Annuler"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            deleteSalle(widget.salleId);
                                            Navigator.pop(context);
                                          },
                                          child: Text("Confirmer"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),

                          //button reserver
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 48.5, vertical: 10),
                              backgroundColor: blueColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Reservation(salleId),
                                ),
                              );
                            },
                            child: Text(
                              'Reserver',
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
//---------------------------Partie reserver button-------------------------
            ],
          );
        },
      ),
    );
  }

//badge des commentaires
  Widget buildBadge() {
    IconData icon;
    Color color;
    switch (_badgeLevel) {
      case BadgeLevel.bronze:
        icon = Icons.verified;
        color = Colors.brown;
        break;
      case BadgeLevel.silver:
        icon = Icons.verified;
        color = Colors.grey;
        break;
      case BadgeLevel.gold:
        icon = Icons.verified;
        color = Colors.amber;
        break;
      case BadgeLevel.diamond:
        icon = Icons.verified;
        color = Colors.blue;
        break;
    }
    return Icon(icon, color: color, size: 16);
  }
}
