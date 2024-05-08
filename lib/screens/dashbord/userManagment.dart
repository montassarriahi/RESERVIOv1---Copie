
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reserviov1/screens/dashbord/UsernonVerifier.dart';


 


class UsersManagementScreen extends StatefulWidget {
  @override
  State<UsersManagementScreen> createState() => _UsersManagementScreenState();
}

class _UsersManagementScreenState extends State<UsersManagementScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Utilisateurs'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            SizedBox(height: 5),
            Text(
              'Modifier les utilisateurs',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                            color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('user').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } 

                   return Column(
                  children: snapshot.data!.docs.map((doc) {
                    return Card(
                      color: Colors.blue[100],
                      child: ListTile(
                        title: Text(
                          doc['email'],
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doc['pass'],
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                              ),
                            ),
                             Text('est un '+
                              doc['role'],
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              deleteuser(doc.id);
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          ), ),
                    );
                  }).toList(),
                );
                
                
            
               
              },
            ),
          ],
        ),
      ),
    );
  }
}
