import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reserviov1/constants/constants.dart';
import 'package:reserviov1/screens/Login/firebaseAuth/FirebaseAuthServices.dart';
import 'package:reserviov1/screens/profile/profile.dart';
import 'package:reserviov1/screens/resultPage.dart';
import 'package:reserviov1/widgets/DropDownInput.dart';
import 'package:reserviov1/widgets/RangeSlider.dart';
import 'package:reserviov1/widgets/RoomPrice.dart';
import 'package:reserviov1/widgets/counterEquipmenr.dart';
import 'package:reserviov1/widgets/daysSelection.dart';
import 'package:reserviov1/widgets/equipemts.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
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
   Map<String, bool> _days = {
    'Lundi': false,
    'Mardi': false,
    'Mercredi': false,
    'Jeudi': false,
    'Vendredi': false,
    'Samedi': false,
    'Dimanche': false,
  };
   String _selectedItem = 'salle evennement';
    List<String> _items = ['salle evennement', 'bureau', 'salle de reunion'];

  

  

 

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
 

 void _searchSalles() async {
  // Récupérer une référence à la collection "salles" dans Firestore
  CollectionReference sallesRef = FirebaseFirestore.instance.collection('salles');

  // Construire la requête en fonction des critères sélectionnés
  Query query = sallesRef;

  // Filtrer par type de salle
  if (_selectedItem != null) {
    query = query.where('type', isEqualTo: _selectedItem);
  }

  // Filtrer par équipements
  selectedEquipments.forEach((equipement, isSelected) {
    if (isSelected) {
      query = query.where('equipments.$equipement', isEqualTo: true);
    }
  });

  // Filtrer par prix
  query = query.where('price', isGreaterThanOrEqualTo: _roomPrice);

  // Filtrer par jours disponibles
  List<String> selectedDays = [];
  _days.forEach((day, isSelected) {
    if (isSelected) {
      selectedDays.add(day);
    }
  });
 if (selectedDays.isNotEmpty) {
    query = query.where('days', arrayContainsAny: selectedDays);
  }

  // Exécuter la requête
  QuerySnapshot querySnapshot = await query.get();

  // Traiter les résultats
  List<DocumentSnapshot> results = querySnapshot.docs;

  // Naviguer vers la page des résultats
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ResultPage(results: results),
    ),
  );
}



 



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
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
               

  
                SizedBox(height: 16),
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
            Text('Jours où la salle est ouverte :'),
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
                Text(
                  "Disponibiliter de la salle ?",
                  style: mediumText,
                ),
                Hieght_SizedBox,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("8:00 am"), Text("10:00 pm")],
                ),
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
                Text(
                  "Entrez les équipements de la salle :",
                  style: mediumText,
                ),
                Hieght_SizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // first column
                    Column(
                      children: [
                        EquipmentsToggle(
                          itemName: 'Wifi',
                          myIcon: Icons.wifi,
                          onPressed: () => toggleEquipment('Wifi'),
                          
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        EquipmentsToggle(
                          itemName: 'Climatiseur',
                          myIcon: Icons.ac_unit,
                          onPressed: () => toggleEquipment('Climatiseur'),
                          
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        EquipmentsToggle(
                          itemName: 'Projecteurs',
                          myIcon: Icons.lightbulb_outline,
                          onPressed: () => toggleEquipment('Projecteurs'),
                          
                        ),
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
                        SizedBox(
                          height: 16,
                        ),
                        EquipmentsToggle(
                          itemName: 'Système de sécurité',
                          myIcon: Icons.security,
                          onPressed: () => toggleEquipment('Système de sécurité'),
                         
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        EquipmentsToggle(
                          itemName: 'Tableau blanc',
                          myIcon: Icons.format_color_text,
                          onPressed: () => toggleEquipment('Tableau blanc'),
                          
                        ),
                        ItemCounter(
                          itemName: 'bureau',
                          myIcon: Icons.table_restaurant_outlined,
                           quantite : _updateDesk,
                        ),
                      ],
                    ),
                  ],
                ),
                // custom widget for price
                PriceRooms(
                  onPriceChanged: _updateRoomPrice,
                ),
                Hieght_SizedBox,
               
  
                
                 SizedBox(height : 16),
                SizedBox(
                  width: 360,
                  height: 56,
                  child: ElevatedButton(
                    onPressed:_searchSalles,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 107, 99, 255),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      
                    ),
                    child: Text(
                      "Rechercher",
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
