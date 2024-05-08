import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


 void deleteuser(String docId) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(docId)
        .delete();
  }

  void acceptuser(String docId){
 FirebaseFirestore.instance.collection('user').doc(docId).update({
                  'verifier': true,
                });
  }
class usernonverifier extends StatefulWidget {
  const usernonverifier({super.key});

  @override
  State<usernonverifier> createState() => _usernonverifierState();
}

class _usernonverifierState extends State<usernonverifier> {
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
              'users qui veut rejoindre reservio',
              style: GoogleFonts.roboto(
                fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('user').where('verifier', isEqualTo: false).snapshots(),
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
                             Text('il veut rejoindre reservio en tant que '+
                              doc['role'],
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        leading: IconButton(onPressed:(){
                          acceptuser(doc.id);
                        }, icon: Icon(Icons.person_add_alt_1 , color : Color.fromARGB(255, 14, 132, 18))),
                      trailing: IconButton(
                            onPressed: () {
                              deleteuser(doc.id);
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                          
                          
                          ),
                          
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