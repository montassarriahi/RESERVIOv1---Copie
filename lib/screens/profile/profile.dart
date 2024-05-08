import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reserviov1/constants/constants.dart';
import 'package:reserviov1/screens/Login/LoginPage.dart';
import 'package:reserviov1/screens/historique.dart';
import 'package:reserviov1/screens/profile/widgets/GetImages.dart';
import 'package:reserviov1/screens/profile/widgets/InputsProfile.dart';
import 'package:reserviov1/screens/profile/widgets/PasswordToggle.dart';

enum BadgeLevel { bronze, silver, gold, diamond }

class UserProfile {
  static String? userId;
}

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  //------------------declaration des variables ---------------------------
  String? userId = UserProfile.userId;
  String? _username = '';
  BadgeLevel _badgeLevel = BadgeLevel.bronze;
  File? _imageFile;
  bool _isNewImageSelected = false;
  @override
  void initState() {
    super.initState();
    _checkBadgeLevel();
  }

//-----------hedi tetchekilek el level mt3k -----------------------------
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

//update lel esm
  Future<void> _updateUsername(String newUsername) async {
    try {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(userId)
          .update({'username': newUsername});
      //success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Username mis à jour avec succès'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      //failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la mise à jour du nom d\'utilisateur'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  //tetchekilek ken 3andek taswira fil base
  bool _hasProfileImage(Map<String, dynamic> userData) {
    return userData.containsKey('photoUrl') && userData['photoUrl'] != null;
  }

  //upload taswira
  Future<void> _uploadImage(File image) async {
    try {
      var storageRef =
          FirebaseStorage.instance.ref().child('profile_images').child(userId!);
      await storageRef.putFile(image);
      var imageUrl = await storageRef.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('user')
          .doc(userId)
          .update({'photoUrl': imageUrl});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Photo de profil mise à jour avec succès'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la mise à jour de la photo de profil'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

//get taswira
  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        _uploadImage(_imageFile!);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text('Profile')),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HistoriquePage(userId: userId)),
                );
              },
              icon: const Icon(
                Icons.history_rounded,
                size: 28,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('user')
              .doc(userId)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              //loading
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              //erreur
              return Text('Error: ${snapshot.error}');
            } else {
              var userData = snapshot.data!.data() as Map<String, dynamic>;
              String email = userData['email'];
              String password = userData['pass'];
              String role = userData['role'];
              _username = userData['username'];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  //tchek type de compte actuel
                  children: [
                    if (role == 'client')
                      Container(
                        child: _buildBadge(),
                      ),
                    if (role == 'Propriétaires')
                      Container(
                        child: _buildBadge(),
                      ),
                    SizedBox(height: 20),

                    ProfileImage(
                      isNewImageSelected: _isNewImageSelected,
                      hasProfileImage: _hasProfileImage(userData),
                      getImage: _getImage,
                      imageFile: _imageFile,
                      userData: userData,
                      getProfileImage:
                          _getProfileImage, // Pass _getProfileImage function here
                    ),

                    SizedBox(height: 50),
                    Stack(
                      children: [
                        //------------------------------------Partie inputs --------------------------------

                        //nom
                        TextField(
                          controller: TextEditingController(text: _username),
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            _username = value;
                          },
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            decoration: BoxDecoration(
                                color: blueColor,
                                borderRadius: BorderRadius.circular(30)),
                            child: IconButton(
                              icon: Icon(
                                Icons.done_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                              onPressed: () {
                                _updateUsername(_username!);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    //mail

                    InputsProfile(
                      Labels: 'Email',
                      InitValue: email,
                    ),

                    const SizedBox(height: 15),

                    // widget for the password
                    PassToggler(
                      PasswordText: password,
                    ),
                    const SizedBox(height: 15),

                    //role
                    InputsProfile(
                      Labels: 'Role',
                      InitValue: role,
                    ),

                    //---------------------------Fin Partie inputs--------------------------------

                    //-----------------------partie des button-------------------------

                    SizedBox(height: 24),

                    //button deconnect
                    SizedBox(
                      width: 360,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blueColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text("Déconnecter"),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

//badge text
  Widget _buildBadge() {
    String badgeText = '';

    switch (_badgeLevel) {
      case BadgeLevel.silver:
        badgeText = 'Silver Badge';
        break;
      case BadgeLevel.gold:
        badgeText = 'Gold Badge';
        break;
      case BadgeLevel.diamond:
        badgeText = 'Diamond Badge';
        break;
      default:
        badgeText = 'Bronze Badge';
        break;
    }

    //---------design container des badges--------------------------------
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: _badgeLevel == BadgeLevel.silver
            ? Colors.grey
            : _badgeLevel == BadgeLevel.gold
                ? Colors.yellow
                : _badgeLevel == BadgeLevel.diamond
                    ? Colors.blue
                    : Colors.brown,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        badgeText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

//getimage
  ImageProvider<Object>? _getProfileImage(Map<String, dynamic> userData) {
    if (userData.containsKey('photoUrl') && userData['photoUrl'] != null) {
      return NetworkImage(userData['photoUrl']);
    } else {
      return null;
    }
  }
}
