import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reserviov1/constants/constants.dart';

class Infos extends StatelessWidget {
  final int nbrSalle;

  // Constructor
  const Infos({
    Key? key,
    required this.nbrSalle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 130,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.5, color: Colors.black12),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Reservio",
              style: headlinesmall,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "L’application n°1 de reservation des salles",
              style: bodysmall,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "${nbrSalle} Salle Disponible",
              style: titlemedium,
            )
          ],
        ),
      ),
    );
  }
}
