import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget Aletdialogue(String Titre , String contenu , String buttonText ,IconData myicon, VoidCallback mafonction ){
 
return AlertDialog (
  icon: Icon(myicon),
  
  insetPadding: EdgeInsets.symmetric(horizontal :60 ),
   shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(28.0))),
  backgroundColor: Colors.white,
 
  
    title: Text(Titre , style: GoogleFonts.roboto(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        fontSize: 22,
                      ),),
    content: Text(contenu,style: GoogleFonts.roboto(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),),
                      
    actions: [
      ElevatedButton(
         style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 107, 99, 255),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
        onPressed: (){ mafonction();}, child:Text(buttonText))
    ],
  );

 
}
