import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reserviov1/constants/constants.dart';

Widget buildEquipmentIcon(String equipment, IconData iconData) {
  return Container(
    width: 100,
    height: 72,
    margin: EdgeInsets.only(right: 16),
    decoration: BoxDecoration(
      color: lightblue,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: 24,
          color: blueColor,
        ),
        const SizedBox(height: 4),
        Text(
          equipment,
          style: GoogleFonts.roboto(
            fontSize: 14,
            color: blueColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}
