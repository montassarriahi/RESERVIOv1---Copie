

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


import 'package:reserviov1/constants/constants.dart';
import 'package:reserviov1/widgets/DropDownInput.dart';
import 'package:reserviov1/widgets/RangeSlider.dart';
import 'package:reserviov1/widgets/RoomPrice.dart';
import 'package:reserviov1/widgets/counterEquipmenr.dart';
import 'package:reserviov1/widgets/daysSelection.dart';

import 'package:reserviov1/widgets/equipemts.dart';

class ModifySalle extends StatefulWidget {
  final String salleId;

  ModifySalle(this.salleId);

  @override
  _ModifySalleState createState() => _ModifySalleState();
}

class _ModifySalleState extends State<ModifySalle> {
  //------------------partie declaration des variables -----------------
  DocumentSnapshot? salleSnapshot;
  TextEditingController nomController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  double _startTime = 8.0;
  
  String? _locationText ;
  Position? _salleLocation;
  double _endTime = 22.0;
  int _roomPrice = 0;
  int _nbrDesk = 0;
  int _nbrchaise = 0 ;
  Map<String, bool> selectedEquipments = {};
  Map<String, bool> _days = {
    'Lundi': false,
    'Mardi': false,
    'Mercredi': false,
    'Jeudi': false,
    'Vendredi': false,
    'Samedi': false,
    'Dimanche': false,
  };


  String _selectedItem = 'Salle événement';
  List<String> _items = ['Salle événement', 'Bureau', 'Salle de réunion','Salle de conférence','Salle d\'exposition','Salle de projection',];

 
   List<String> selectedDays = [];
  
  @override
  void initState() {
    super.initState();
    
    _loadSalleData();
     selectedDays = [];
  }
  //partie njib menha el salle ely ena feha tw
  Future<void> _loadSalleData() async {
    
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("salles").doc(widget.salleId).get();

  print("Snapshot data: ${snapshot.data()}");
    
    setState(() {
       //nhot les donner mte3i a jour
   
    
      salleSnapshot = snapshot;
      nomController.text = snapshot['Nom'];
      adresseController.text = snapshot['adresse'];
      _startTime = snapshot['startTime'];
      _endTime = snapshot['endTime'];
      _roomPrice = snapshot['price'];
      _nbrDesk = snapshot['bureaux'];
      _nbrchaise = snapshot['chaises'];
      
      _selectedItem = snapshot['type'];
     
     
  
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier la salle"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
//-----------------Partie Formulaire 3 inputts -----------------------  

              //nom input
              TextFormField(
                controller: nomController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  hintText: 'Nom de la salle',
                ),
              ),

              SizedBox(height: 16),

              //adress input
              TextFormField(
                controller: adresseController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  hintText: 'Adresse',
                ),
              ),
               SizedBox(height: 16),

               //type dropdown
              DropdownWidget(
                items: _items,
                selectedOne: _selectedItem,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedItem = newValue!;
                  });
                },
              ),

//-----------------Fin Partie Formulaire 3 inputts -----------------------  

              SizedBox(height: 16),
//-----------------button localisation --------------------------------
              ElevatedButton(
                onPressed: () async {
                  await _getCurrentLocation();
                  if (_salleLocation != null) {
                    final String latitude = _salleLocation!.latitude.toString();
                    final String longitude = _salleLocation!.longitude.toString();
                    final String locationText = "Latitude: $latitude, Longitude: $longitude";
                    setState(() {
                      _locationText = locationText;
                    });
                  } else {
                    setState(() {
                      _locationText = "Impossible de récupérer la localisation.";
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 107, 99, 255),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("Obtenir la localisation"),
              ),
              Text(_locationText ?? ""),
 //---------------------fin button localisation -------------------------------------    
        
              SizedBox(height: 16),
             

//-------------------- Partie jours --------------------------------------- 

              Text('Jours où la salle est ouverte :'),
               Text("champs obligatoire meme si vous n'avez pas des modification a apporter*",
               style: TextStyle(color: Colors.red),),
              SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DaySelectionWidget(
                  days: _days,
                  onToggle: (day, isSelected) {
                    setState(() {
                      _days[day] = isSelected;
                    });
                  },
                ),
              ),

//----------------------Fin partie jours ------------------------------------------
              SizedBox(height: 16),

//------------------Debut Partie temp------------------------------------------------              
              Text(
                "Entrez les heures de disponibilité de la salle :",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Heure de début: $_startTime"),
                  Text("Heure de fin: $_endTime"),
                ],
              ),
              SizedBox(height: 8),
              //Slider tal9ah fil widgets
              TimeSlider(
                startTime: _startTime,
                endTime: _endTime,
                onChanged: (start, end) {
                  setState(() {
                    _startTime = start;
                    _endTime = end;
                  });
                },
              ),

//------------------Debut Partie temp------------------------------------------------     

              SizedBox(height: 16),

 //---------------------Debut Partie equipements -------------------------------------            
              Text(
                "Entrez les équipements de la salle :",
                style: mediumText,
              ), Text(
                "s'il vous plait selectionner les equipement de votre salle meme si n'ont pas changer*",
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // first column

                  //Wifi
                  Column(
                    children: [
                      EquipmentsToggle(
                        itemName: 'Wifi',
                        myIcon: Icons.wifi,
                        onPressed: () => toggleEquipment('Wifi'),
                      ),
                      SizedBox(height: 16),

                      //Climatiseur
                      EquipmentsToggle(
                        itemName: 'Climatiseur',
                        myIcon: Icons.ac_unit,
                        onPressed: () => toggleEquipment('Climatiseur'),
                      ),
                      SizedBox(height: 16),

                      //Projecteur
                       EquipmentsToggle(
                        itemName: 'Projecteurs',
                        myIcon: Icons.lightbulb_outline,
                        onPressed: () => toggleEquipment('Projecteurs'),
                      ),

                      //chaises
                      ItemCounter(
                        itemName: 'chaise',
                        myIcon: Icons.chair_alt_outlined,
                        quantite: _updatechaise,
                      ),
                    ],
                  ),

                  // sec column
                  Column(
                    children: [

                      //Ecrans
                       EquipmentsToggle(
                        itemName: 'Ecrans',
                        myIcon: Icons.monitor,
                        onPressed: () => toggleEquipment('Ecrans'),
                      ),
                      SizedBox(height: 16),

                      //Systeme sec
                      EquipmentsToggle(
                        itemName: 'Système de sécurité',
                        myIcon: Icons.security,
                        onPressed: () => toggleEquipment('Système de sécurité'),
                      ),
                      SizedBox(height: 16),

                      //tableau
                       EquipmentsToggle(
                        itemName: 'Tableau blanc',
                        myIcon: Icons.format_color_text,
                        onPressed: () => toggleEquipment('Tableau blanc'),
                      ),

                      //bureau
                      ItemCounter(
                        itemName: 'bureau',
                        myIcon: Icons.table_restaurant_outlined,
                        quantite: _updateDesk,
                      ),
                    ],
                  ),
                ],
              ),
               //prix
              PriceRooms(
                onPriceChanged: _updateRoomPrice,
              ), 

//------------------Fin partie equipements------------------------------------------------     
              SizedBox(height: 16),

//Partie des alert des obligation
           
 Text("les champs avec  * sont obligatoires",
               style: TextStyle(color: Colors.red),),
               Text("si vos chamgement plus grand que ca il faut supprimer et repostuler la salle !",
               style: TextStyle(color: Colors.red),),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _updateSalle,
                child: Text("Enregistrer les modifications"),
              ),
            ],
          ),
        ),
      ),
    );
  }

 
  

//Fuction udate
 Future<void> _updateSalle() async {
  
  String nom = nomController.text;
  String adresse = adresseController.text;

  Map<String, dynamic> salleDataToUpdate = {};

  if (nom != salleSnapshot!['Nom']) {
    salleDataToUpdate['Nom'] = nom;
  }

  // update adress
  if (adresse != salleSnapshot!['adresse']) {
    salleDataToUpdate['adresse'] = adresse;
  }

  //update starttime
  if (_startTime != salleSnapshot!['startTime']) {
    salleDataToUpdate['startTime'] = _startTime;
  }

  //update end time
  if (_endTime != salleSnapshot!['endTime']) {
    salleDataToUpdate['endTime'] = _endTime;
  }

  //update price
  if (_roomPrice != salleSnapshot!['price']) {
    salleDataToUpdate['price'] = _roomPrice;
  }

  //udate desks
  if (_nbrDesk != salleSnapshot!['bureaux']) {
    salleDataToUpdate['bureaux'] = _nbrDesk;
  }

  //update chaises 
  if (_nbrchaise != salleSnapshot!['chaises']) {
    salleDataToUpdate['chaises'] = _nbrchaise;
  }

  //upadate equipements
  if (selectedEquipments != salleSnapshot!['equipments']) {
    salleDataToUpdate['equipments'] = selectedEquipments;
  }
  
  //days upadate
  selectedDays.clear();
  _days.forEach((day, isSelected) {
    if (isSelected) {
      selectedDays.add(day);
    }
  });

  
  List<dynamic> daysArray = selectedDays;

 
  if (!listEquals(daysArray, salleSnapshot!['days'])) {
    salleDataToUpdate['days'] = daysArray;
  }
 
 

 
  if (salleDataToUpdate.isNotEmpty) {
    await FirebaseFirestore.instance.collection("salles").doc(widget.salleId).update(salleDataToUpdate);
  }
// show dialog bch t9olek modif terminer
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Salle modifiée"),
        content: Text("Les modifications ont été enregistrées avec succès."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}



 


//function mt3 localisation
  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Demander à nouveau l'autorisation
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // L'utilisateur a à nouveau refusé l'autorisation, afficher un message d'erreur
        print('L\'utilisateur a refusé l\'autorisation d\'accéder à la localisation.');
        return;
      }
    }

    // Si l'autorisation est accordée, obtenir la localisation
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _salleLocation = position;
      });
    } catch (e) {
      print("Erreur lors de la récupération de la localisation : $e");
    }
  }
 //les fonction des updates
  void _updateDesk(int Desks) {
    setState(() {
      _nbrDesk = Desks;
    });
  }

  void _updatechaise(int chaise) {
    setState(() {
      _nbrchaise = chaise;
    });
  }

  void _updateRoomPrice(int price) {
    setState(() {
      _roomPrice = price;
    });
  }

  void toggleEquipment(String itemName) {
    setState(() {
      selectedEquipments[itemName] = !(selectedEquipments[itemName] ?? false);
      print('Equipments: $selectedEquipments');
    });
  }
}
