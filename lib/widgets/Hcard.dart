import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Hcard extends StatelessWidget {
  const Hcard({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      width: 600,
      height: 130,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.5, color: Colors.black12),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      // Row to store all the carddata
      child: Row(
        // column
        children: [
          Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/salle.png"),
                  fit: BoxFit.cover),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 12,
              top: 8,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Premium espace'),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      // Icon(
                      //   Icons.location_pin,
                      //   size: 18,
                      // ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.star),
                        padding: EdgeInsets.zero,
                      ),
                      Text('adresse'),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text('20 dt/heure'),
                  SizedBox(
                    height: 4,
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
