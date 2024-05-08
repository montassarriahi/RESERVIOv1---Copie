import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:reserviov1/constants/constants.dart';

class HistoriquePage extends StatelessWidget {
  final String? userId;

  HistoriquePage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('fr', null);

    return Scaffold(
      appBar: AppBar(
        title: Text("Historique"),
      ),
      body: StreamBuilder(
        //njib fil historique mel base
        stream: FirebaseFirestore.instance
            .collection('historique')
            .where('client', isEqualTo: userId)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          //erreur
          else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            //nsob fehom fi map
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  var data = document.data() as Map<String, dynamic>;
                  var date = (data['timestamp'] as Timestamp).toDate();
                  var formattedDate = DateFormat.yMMMMd('fr').format(date);
//---------------partie card ely feha el historique ---------------------
                  return Card(
                    color: blueColor,
                    margin: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //hehne el content mt3 el card
                          Text(
                            'Nom: ${data['nom']}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Adresse: ${data['adresse']}',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Date: $formattedDate',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'de : ${data['startTime']} a ${data['endTime']}',
                            style: TextStyle(color: Colors.white),
                          ),

                          SizedBox(height: 4),
                          Text(
                            'Prix: ${data['price']}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );

//----------fin partie Card --------------------------
                }).toList(),
              );
            } else {
              //lehne ki yabdama3andich hata historique
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SvgPicture.asset("assets/images/empty.svg"),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Text(
                    "Aucune réservation passée",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: darkblue)),
                  ))
                ],
              );
            }
          }
        },
      ),
    );
  }
}
