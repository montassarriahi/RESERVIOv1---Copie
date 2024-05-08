import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:reserviov1/constants/constants.dart';
import 'package:reserviov1/screens/Login/firebaseAuth/FirebaseAuthServices.dart';
import 'package:reserviov1/screens/profile/profile.dart';

import 'package:reserviov1/widgets/ReservationSlider.dart';
import 'package:intl/intl.dart';
import 'package:reserviov1/widgets/offercontainer.dart';
import 'package:intl/date_symbol_data_local.dart';

class Reservation extends StatefulWidget {

  
   final String salleId;
   Reservation(this.salleId);

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  //partie declaration
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  double? startTime;
double? endTime;
DateTime? selectedDate;
List<String> availableDays = [];
String? selectedDay;
double amountToPay = 0.0;
double? tempMin;
double? tempMax;
 List<dynamic> conversation = [];
 String? start ;
 String? end ;


//fuction ajouter res
 void addReservation(String owner, String nom, String adresse, double startTime, double endTime, String price, String client, String day , String date) {
  FirebaseFirestore.instance.collection("reservation").add({
    'owner': owner,
    'Nom': nom,
    'adresse': adresse,
    'client': client,
    'etat': 'en attente',
    'startTime': startTime,
    'endTime': endTime,
    'salleid': widget.salleId,
    'price': price,
    'day': day,
    'conversation': conversation,
    'date': date, 
  });
}

//chech existed res
Future<bool> checkExistingReservation(double startTime, double endTime, String? day) async {
  CollectionReference reservationsRef = FirebaseFirestore.instance.collection("reservation");

  try {
    QuerySnapshot querySnapshot = await reservationsRef
      .where('salleid', isEqualTo: widget.salleId) 
      .where('day', isEqualTo: day) 
      .where('etat', isEqualTo: 'accepter')
      .get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      double existingStartTime = doc['startTime'];
      double existingEndTime = doc['endTime'];

      if (startTime < existingEndTime && existingStartTime < endTime) {
        // Il y a un chevauchement, la salle est déjà réservée à ce moment-là
        return true;
      }
    }

    
    return false;
  } catch (error) {
    print("Erreur lors de la récupération des réservations: $error");
    
    return false;
  }
}


     DateTime? today;

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
  initializeDateFormatting('fr', null); 
  }
   

@override
Widget build(BuildContext context) {
 
   
    
  //tcheking the week day 
     String formattedDate = "${today!.day}/${today!.month}/${today!.year}";
  String dayOfWeek = '';
  switch (today!.weekday) {
    case 1:
      dayOfWeek = 'Lundi';
      break;
    case 2:
      dayOfWeek = 'Mardi';
      break;
    case 3:
      dayOfWeek = 'Mercredi';
      break;
    case 4:
      dayOfWeek = 'Jeudi';
      break;
    case 5:
      dayOfWeek = 'Vendredi';
      break;
    case 6:
      dayOfWeek = 'Samedi';
      break;
    case 7:
      dayOfWeek = 'Dimanche';
      break;
    default:
      dayOfWeek = '';
      break;
  }

  String selectedDateText = '';
 bool isPastDate = false;
String? selectedDateMessage = '';

if (selectedDay != null) {
  DateTime selectedDateTime = today!;

  // Trouver le jour de la semaine correspondant
  switch (selectedDay!.toLowerCase()) {
    case 'lundi':
      selectedDateTime = today!.add(Duration(days: 1 - today!.weekday));
      break;
    case 'mardi':
      selectedDateTime = today!.add(Duration(days: 2 - today!.weekday));
      break;
    case 'mercredi':
      selectedDateTime = today!.add(Duration(days: 3 - today!.weekday));
      break;
    case 'jeudi':
      selectedDateTime = today!.add(Duration(days: 4 - today!.weekday));
      break;
    case 'vendredi':
      selectedDateTime = today!.add(Duration(days: 5 - today!.weekday));
      break;
    case 'samedi':
      selectedDateTime = today!.add(Duration(days: 6 - today!.weekday));
      break;
    case 'dimanche':
      selectedDateTime = today!.add(Duration(days: 7 - today!.weekday));
      break;
    case 'lundi prochain':
      selectedDateTime = today!.add(Duration(days: 8 - today!.weekday));
      break;
    case 'mardi prochain':
      selectedDateTime = today!.add(Duration(days: 9 - today!.weekday));
      break;
    case 'mercredi prochain':
      selectedDateTime = today!.add(Duration(days: 10 - today!.weekday));
      break;
    case 'jeudi prochain':
      selectedDateTime = today!.add(Duration(days: 11 - today!.weekday));
      break;
    case 'vendredi prochain':
      selectedDateTime = today!.add(Duration(days: 12 - today!.weekday));
      break;
    case 'samedi prochain':
      selectedDateTime = today!.add(Duration(days: 13 - today!.weekday));
      break;
    case 'dimanche prochain':
      selectedDateTime = today!.add(Duration(days: 14 - today!.weekday));
      break;
  }

  
  if (selectedDateTime.isBefore(DateTime.now())) {
    selectedDateMessage = 'Attention : Cette date est déjà passée.';
     isPastDate = true;
  }

  selectedDateText = DateFormat('dd/MM/yyyy').format(selectedDateTime);
}

 
  String? userId = UserProfile.userId;
  return Scaffold(
    appBar: AppBar(
      title: Text("Réservation"),
      centerTitle: true,
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection('salles').doc(widget.salleId).get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            //loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              //n'existe pas
              return Center(child: Text('La salle n\'existe pas.'));
            }

            //recup des donner
            var data = snapshot.data!.data() as Map<String, dynamic>;
            String jours = data['days'].toString();
            jours = jours.replaceAll('[', '');
            jours = jours.replaceAll(']', '');
            jours = jours.replaceAll(',', '');

            availableDays = jours.split(' ');

            double min = data['startTime'];
            double max = data['endTime'];
            int price = data['price'];

             String owner = data['owner'];

            return Column( 
      
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
//----------------------Partie container fih nom + adresse ---------------
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //nom
                      Text(
                        'Nom de la salle : ${data['Nom']}',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      //adresse
                      Text(
                        'Adresse : ${data['adresse']}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
 //----------------------Fin Partie container fih nom + adresse ------------------------            
                SizedBox(height: 20),

//-------------------------------------Partie days -----------------------------------                
                //text date d'ajourdhui
                Text(
          "La reservation des jours a partir de la semaine de $dayOfWeek le $formattedDate",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        //conteneur des jours ylemhom lkol fard container
                Container(
                  width: MediaQuery.of(context).size.width, 
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      Column(
                        //partie ejour
                        children: availableDays
                            .map(
                              (day) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDay = day;
                                  });
                                },
                                child: Chip(
                                  label: Text(day),
                                  backgroundColor: selectedDay == day ? blueColor : null,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      Column(
                        children: availableDays
                            .map(
                              (day) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDay = day + ' prochain';
                                  });
                                },
                                child: Chip(
                                  label: Text(day + ' prochain'),
                                  backgroundColor: selectedDay == day + ' prochain' ? blueColor : null,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
     
               SizedBox(height: 20),

//affiche jour de la sem
Text(
  'Jour sélectionné : ${selectedDay ?? "Aucun"}',
  textAlign: TextAlign.center,
  style: TextStyle(fontSize: 18),
),
SizedBox(height: 10),
//affiche date
 Text(
  'Jour sélectionné : ${selectedDateText ?? "Aucun"}',
  textAlign: TextAlign.center,
  style: TextStyle(fontSize: 18, color: isPastDate ? Colors.red : null),
),
//alert si jour est passer
if (selectedDateMessage != null && selectedDateMessage.isNotEmpty)
  Text(
    selectedDateMessage!,
    textAlign: TextAlign.center,
    style: TextStyle(color: Colors.red),
  ),
  
 //-------------------------------------Fin Partie days -----------------------------------  
 

  //-------------------------------------Partie Time -----------------------------------  

                SizedBox(height: 20),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${data['startTime'].toStringAsFixed(0)}:00'),
                        Text('${data['endTime'].toStringAsFixed(0)}:00'),
                      ],
                    ),
                    //range value tal9ah fil widgets
                    RangeValuesSlider(
                      start: min,
                      end: max,
                      min: min,
                      max: max,
                      onChanged: (newMin, newMax) {
                        tempMin = newMin;
                        tempMax = newMax;
                        print('New Min: $tempMin, New Max: $tempMax');
                      },
                    ),
  //-------------------------------------Partie Time -----------------------------------  
  //                  
                    SizedBox(height: 40),

  //-------------------------------------Partie conteneur prix -----------------------------------  
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'prix par heure ',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          
                          Text( 
                            '$price Dt',
                            style: TextStyle(fontSize: 16),
                          ),
                          
                  
                        ],
                      ),
                    ),
 //-------------------------------Fin Partie Time -----------------------------------      
                
                    SizedBox(height:16),

//----------------button passer reservation --------------------------------------
     
                   ElevatedButton(
                    //yebda activate ken date n'est pas passer
  onPressed:isPastDate ? null : () async  {
    setState(() {
        startTime = tempMin;
        endTime = tempMax;
        double hours = endTime! - startTime!;
        amountToPay = (hours * price).toDouble();
        amountToPay = double.parse(amountToPay.toStringAsFixed(2));
         String start = '${startTime?.toStringAsFixed(0)}:00';
String end= '${endTime?.toStringAsFixed(0)}:00';
      });
   print('startTime: $startTime, endTime: $endTime, selectedDay: $selectedDay');
    //ycheki ken fama reservation fi nhar heda
    bool alreadyReserved = await checkExistingReservation( startTime!, endTime! ,selectedDay );

//ken fama yaffichi impossible
    if (alreadyReserved) {

      print(alreadyReserved);
     //showdialog impossible
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Impossible de réserver'),
            content: Text('il existe Une réservation le $selectedDay du ${startTime?.toStringAsFixed(0)}:00 a ${endTime?.toStringAsFixed(0)}:00 essayer avec un autre temps ou autres salles '),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Fermer'),
              ),
            ],
          );
        },
      );
    } else {
      
      setState(() {
        startTime = tempMin;
        endTime = tempMax;
        double hours = endTime! - startTime!;
        amountToPay = (hours * price).toDouble();
        amountToPay = double.parse(amountToPay.toStringAsFixed(2));
        String start = '${startTime?.toStringAsFixed(0)}:00';
String end= '${endTime?.toStringAsFixed(0)}:00';
      });

      //sinon y3adilek el res
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Récapitulatif de la réservation'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //info de la recap reservation
                  Text('Nom de la salle : ${data['Nom']}'),
                      SizedBox(height: 10),
                      Text('Adresse : ${data['adresse']}'),
                      SizedBox(height: 10),
                      Text('Jour sélectionné : ${selectedDay ?? "Aucun"}'),
                      SizedBox(height: 10),
                      Text('Date de la reservation : ${selectedDateText}'),
                      SizedBox(height: 10),
                      Text('Heure de début : ${startTime!.toStringAsFixed(0)}:00'),
                      SizedBox(height: 10),
                      Text('Heure de fin : ${max.toStringAsFixed(0)}:00'),
                      SizedBox(height: 10),
                      Text('Prix total (avec remise) : ${amountToPay.toStringAsFixed(0)} Dt'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Fermer'),
              ),
            ],
          );
        },
      );

   //fuction ajouter res ala base    
      addReservation(
        owner,
        '${data['Nom']}',
        '${data['adresse']}',
          startTime!,
        endTime!,
        '${amountToPay.toStringAsFixed(0)} Dt',
        userId!,
        '${selectedDay}',
        '${selectedDateText}'
      );
    }
  },
  child: Text('Passer réservation'),
),

//----------------Fin partie button passer reservation --------------------------------------

//----------------partie button des offres  --------------------------------------

Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    SizedBox(height: 16,),

    // -------------------------Offre 1 nhar kemel--------------------
    GestureDetector(
      onTap: () async {
        setState(() {
          startTime = min;
          endTime = max;
          amountToPay = (max - min) * price * 0.9; 
          amountToPay = double.parse(amountToPay.toStringAsFixed(2));
        });
        

        bool alreadyReserved = await checkExistingReservation(startTime!, endTime!, selectedDay);

        if (!alreadyReserved) {
          showDialog(
            //recap dialog ken jawha behy y3adilek sinon yaffichi fama res fi nhar hedeka
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Récapitulatif de la réservation'),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Nom de la salle : ${data['Nom']}'),
                      SizedBox(height: 10),
                      Text('Adresse : ${data['adresse']}'),
                      SizedBox(height: 10),
                      Text('Jour sélectionné : ${selectedDay ?? "Aucun"}'),
                      SizedBox(height: 10),
                      Text('Date de la reservation : ${selectedDateText}'),
                      SizedBox(height: 10),
                      Text('Heure de début : ${startTime!.toStringAsFixed(0)}:00'),
                      SizedBox(height: 10),
                      Text('Heure de fin : ${max.toStringAsFixed(0)}:00'),
                      SizedBox(height: 10),
                      Text('Prix total (avec remise) : ${amountToPay.toStringAsFixed(0)} Dt'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Fermer'),
                  ),
                ],
              );
            },
          );

          addReservation(
            owner,
            '${data['Nom']}',
            '${data['adresse']}',
            startTime!,
            endTime!,
            '${amountToPay.toStringAsFixed(0)} Dt',
            userId!,
            selectedDay!,
            '${selectedDateText}'
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Impossible de réserver'),
                content: Text('Il existe déjà une réservation pour cette plage horaire. Veuillez choisir une autre offre ou une autre salle.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Fermer'),
                  ),
                ],
              );
            },
          );
        }
      },
      //offre container widget feha design tal9aha fil widgets
      child: OfferContainer(
        title: "Toute la journée avec 10% de remise",
        description: "Réservez la journée entière avec 10% de remise",
      ),
    ),
    SizedBox(height: 16),



    //----------------------------- Offre  2 nos nhar louleni--------------------------
    GestureDetector(
      onTap: () async {
        setState(() {
          startTime = min;
          endTime = min + ((max - min) / 2); 
          amountToPay = ((max - min) / 2) * price * 0.95; 
          amountToPay = double.parse(amountToPay.toStringAsFixed(2));
        });

        bool alreadyReserved = await checkExistingReservation(startTime!, endTime!, selectedDay);

        if (!alreadyReserved) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Récapitulatif de la réservation'),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                     Text('Nom de la salle : ${data['Nom']}'),
                      SizedBox(height: 10),
                      Text('Adresse : ${data['adresse']}'),
                      SizedBox(height: 10),
                      Text('Jour sélectionné : ${selectedDay ?? "Aucun"}'),
                      SizedBox(height: 10),
                      Text('Date de la reservation : ${selectedDateText}'),
                      SizedBox(height: 10),
                      Text('Heure de début : ${startTime!.toStringAsFixed(0)}:00'),
                      SizedBox(height: 10),
                      Text('Heure de fin : ${max.toStringAsFixed(0)}:00'),
                      SizedBox(height: 10),
                      Text('Prix total (avec remise) : ${amountToPay.toStringAsFixed(0)} Dt'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Fermer'),
                  ),
                ],
              );
            },
          );

          addReservation(
            owner,
            '${data['Nom']}',
            '${data['adresse']}',
            startTime!,
            endTime!,
            '${amountToPay.toStringAsFixed(0)} Dt',
            userId!,
            selectedDay!,
            '${selectedDateText}'
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Impossible de réserver'),
                content: Text('Il existe déjà une réservation pour cette plage horaire. Veuillez choisir une autre offre ou une autre salle.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Fermer'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: OfferContainer(
        title: "Première moitié de la journée avec 5% de remise",
        description: "Réservez la première moitié de la journée avec 5% de remise",
      ),
    ),
   SizedBox(height: 16),


    //-------------------------------- Offre 3 nos har el theni-----------------------------------

    GestureDetector(
      onTap: () async {
        setState(() {
          startTime = min + ((max - min) / 2); 
          endTime = max;
          amountToPay = ((max - min) / 2) * price * 0.95; 
          amountToPay = double.parse(amountToPay.toStringAsFixed(2));
        });

        bool alreadyReserved = await checkExistingReservation(startTime!, endTime!, selectedDay);

        if (!alreadyReserved) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Récapitulatif de la réservation'),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Nom de la salle : ${data['Nom']}'),
                      SizedBox(height: 10),
                      Text('Adresse : ${data['adresse']}'),
                      SizedBox(height: 10),
                      Text('Jour sélectionné : ${selectedDay ?? "Aucun"}'),
                      SizedBox(height: 10),
                      Text('Date de la reservation : ${selectedDateText}'),
                      SizedBox(height: 10),
                      Text('Heure de début : ${startTime!.toStringAsFixed(0)}:00'),
                      SizedBox(height: 10),
                      Text('Heure de fin : ${max.toStringAsFixed(0)}:00'),
                      SizedBox(height: 10),
                      Text('Prix total (avec remise) : ${amountToPay.toStringAsFixed(0)} Dt'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Fermer'),
                  ),
                ],
              );
            },
          );

          addReservation(
            owner,
            '${data['Nom']}',
            '${data['adresse']}',
            startTime!,
            endTime!,
            '${amountToPay.toStringAsFixed(0)} Dt',
            userId!,
            selectedDay!,
            '${selectedDateText}'
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Impossible de réserver'),
                content: Text('Il existe déjà une réservation pour cette plage horaire. Veuillez choisir une autre offre ou une autre salle.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Fermer'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: OfferContainer(
        title: "Deuxième moitié de la journée avec 5% de remise",
        description: "Réservez la deuxième moitié de la journée avec 5% de remise",
      ),
    ),
  ],
)

//----------------Fin partie des button offres ------------------------------------------------
            ],
                ),
              ],
            );
          },
        ),
      ),
    ),
  );
}}