import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reserviov1/constants/constants.dart';
import 'package:reserviov1/screens/Login/firebaseAuth/FirebaseAuthServices.dart';
import 'package:reserviov1/screens/profile/profile.dart';
import 'package:reserviov1/widgets/Alertdialogue.dart';
import 'package:reserviov1/widgets/DropDownInput.dart';
import 'package:reserviov1/widgets/RangeSlider.dart';
import 'package:reserviov1/widgets/RoomPrice.dart';
import 'package:reserviov1/widgets/counterEquipmenr.dart';
import 'package:reserviov1/widgets/daysSelection.dart';
import 'package:reserviov1/widgets/equipemts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage ;


class AddSalle extends StatefulWidget {
  const AddSalle({Key? key}) : super(key: key);

  @override
  State<AddSalle> createState() => _AddSalleState();
}

class _AddSalleState extends State<AddSalle> {

//----------------partie declaration des variables------------------------
  String? _locationText ;
  Map<String, bool> selectedEquipments = {};
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  final TextEditingController NomSalleController = TextEditingController();
  final TextEditingController AdresseController = TextEditingController();
  double _startTime = 8.0;
  double _endTime = 22.0;
  int _roomPrice = 0;
  int  _nbrDesk = 0;
  int _nbrchaise = 0 ;
  List<String> commentaires = [];
  File? _imageFile;
  String _selectedItem = 'Salle événement';
  List<String> _items = ['Salle événement', 'Bureau', 'Salle de réunion','Salle de conférence','Salle d\'exposition','Salle de projection',];
  Position? _salleLocation;
  Map<String, bool> _days = {
    'Lundi': false,
    'Mardi': false,
    'Mercredi': false,
    'Jeudi': false,
    'Vendredi': false,
    'Samedi': false,
    'Dimanche': false,
  };
  List<File> _imageFiles = [];
  

  
// function add salle lel fire base
  void addRoom(String owner, String nom, String adresse, String type, 
      double startTime, double endTime, int price, Map<String, bool> equipments , List<String>? imageUrls ,String etat  ) async {
        List<String> selectedDays = [];
    _days.forEach((day, isSelected) {
      if (isSelected) {
        selectedDays.add(day);
      }
    });
    await FirebaseFirestore.instance.collection("salles").add({
      'owner': owner,
      'Nom': nom,
      'adresse': adresse,
      'verifier': false,
      'type': type,
      'startTime': startTime,
      'endTime': endTime,
      'price': price,
      'equipments': equipments,
      'imageUrls': imageUrls,
      'days' : selectedDays,
      'rating' : 0.0 ,
      'commentaires': commentaires,
      'bureaux' : _nbrDesk ,
      'chaises' : _nbrchaise ,
      'etat' : etat ,
      'location': GeoPoint(_salleLocation!.latitude, _salleLocation!.longitude),
    });
  }

  void _updateRoomPrice(int price) {
    setState(() {
      _roomPrice = price;
    });
  }
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

  void toggleEquipment(String itemName) {
    setState(() {
     selectedEquipments[itemName] = !(selectedEquipments[itemName] ?? false);
     print('Equipments: $selectedEquipments');
    });
  }
  // Méthode njib taswira mel la galerie
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();

    if (images != null) {
      setState(() {
        _imageFiles = images.map((image) => File(image.path)).toList();
      });
    }
  }

  
  // Méthode nsobe beha taswira fil Firebase 
 Future<List<String>> _uploadImages() async {
  List<String> imageUrls = [];

  for (File imageFile in _imageFiles) {
    final firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage
        .instance
        .ref()
        .child('salle_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

    await storageRef.putFile(imageFile);
    String imageUrl = await storageRef.getDownloadURL();
    imageUrls.add(imageUrl);
  }

  return imageUrls;
}
   


 void Fermer() {
    Navigator.of(context).pop();
  }


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
  }}

  @override
  Widget build(BuildContext context) {
    String? userId = UserProfile.userId;

    return Scaffold(
      appBar: AppBar(
        title: Text('Postuler salle'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
//-------------------------------------partie formulaire 3 inputs ------------------------
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                //input nom de la salle
                TextFormField(
                  controller: NomSalleController,
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

                //input adresse de la salle
                TextFormField(
                  controller: AdresseController,
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
//-------------------------------------Fin partie formulaire 3 inputs ------------------------
                
                 SizedBox(height: 16),


               //button get location
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
                      ),),
                         child: Text("Obtenir la localisation"),
                        ),
                //text n'affichi bih el localisation
                 Text(_locationText ?? ""),
  
                SizedBox(height: 16),

//---------------------partie type dropdown mt3 salle------------------------

                DropdownWidget(
                  items: _items,
                  selectedOne: _selectedItem,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedItem = newValue!;
                    });
                  },
                ),

                SizedBox(height: 16),
                SizedBox(height: 16),

//-------------------------partie selection des jours----------------------

            Text('Jours où la salle est ouverte :'),
            SizedBox(height: 16),
                
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  //widget feha el selection des jours tal9aha fil widgets 
                  child: DaySelectionWidget(
                    days: _days,
                    onToggle: (day, isSelected) {
                      setState(() {
                        _days[day] = isSelected;
                      });
                    },
                  ),
                ),

//-----------------partie selection des heures------------------------ 
                Text(
                  "Disponibiliter de la salle ?",
                  style: mediumText,
                ),
                Hieght_SizedBox,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("8:00 am"), Text("10:00 pm")],
                ),

                //Slider ely tpiki bih el wa9t tal9ah fil dossie widget
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
//-----------------Fin partie selection des heures------------------------ 


// ------------------------Debut partie equipements----------------------------
                Text(
                  "Entrez les équipements de la salle :",
                  style: mediumText,
                ),
                Hieght_SizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //lkolha des widget toogleEquipments tal9aha fil widgets
                    // first column
                    Column(
                      children: [
                        //Wifi
                        EquipmentsToggle(
                          itemName: 'Wifi',
                          myIcon: Icons.wifi,
                          onPressed: () => toggleEquipment('Wifi'),
                          
                        ),

                        SizedBox( height: 16,),
 
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

                        //Kresi
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
                        EquipmentsToggle(
                          itemName: 'Ecrans',
                          myIcon: Icons.monitor,
                          onPressed: () => toggleEquipment('Ecrans'),
                         
                        ),

                        SizedBox(height: 16),

                        //systeme de secutite
                        EquipmentsToggle(
                          itemName: 'Système de sécurité',
                          myIcon: Icons.security,
                          onPressed: () => toggleEquipment('Système de sécurité'),
                         
                        ),


                        SizedBox(height: 16,),

                        //tableau
                        EquipmentsToggle(
                          itemName: 'Tableau blanc',
                          myIcon: Icons.format_color_text,
                          onPressed: () => toggleEquipment('Tableau blanc'),
                          
                        ),

                        //twewel
                        ItemCounter(
                          itemName: 'bureau',
                          myIcon: Icons.table_restaurant_outlined,
                           quantite : _updateDesk,
                        ),
                      ],
                    ),
                  ],
                ),
                //prix 
                PriceRooms(
                  onPriceChanged: _updateRoomPrice,
                ),

// ------------------------Debut partie equipements----------------------------

                Hieght_SizedBox,


 //------parier selection des Images hedi metmeshech design w code jawha behi M3 ye5demoha haka----              
                 Container(
  width: double.infinity,
  height: 200, 
  color: Colors.grey[300], 
  child: _imageFiles.isEmpty
      ? IconButton(
          onPressed: _pickImage,
          icon: Icon(Icons.add_photo_alternate),
          iconSize: 50, 
        )
      : ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _imageFiles.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Image.file(
                    _imageFiles[index],
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: () {
                        setState(() {
                          _imageFiles.removeAt(index);
                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
),
  //Fin partie Image
                
                 SizedBox(height : 16),

                 //button Ajouter salle
                SizedBox(
                  width: 360,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () async {
                      List<String> imageUrls = await _uploadImages();
                      addRoom(userId!, NomSalleController.text,
                          AdresseController.text, _selectedItem, _startTime,
                          _endTime, _roomPrice, selectedEquipments ,  imageUrls, 'disponible' );
                          //show diagialog Fermer
                    showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Aletdialogue(
                                        "Salle ajouter avec succes",
                                        "Félicitations ! Votre demande d'ajout de salle a été envoyée avec succès. Nous sommes ravis de vous accueillir dans la communauté Reservio . Veuillez vérifier votre salles . des que l'admin verifier votre salle elle sera ajouter.",
                                        "Fermer",
                                        Icons.mobile_friendly,
                                        Fermer);
                                  },
                                );
                   
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 107, 99, 255),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      
                    ),
                    child: Text(
                      "Ajouter la salle",
                      style: RegularText,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
