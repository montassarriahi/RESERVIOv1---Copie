import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reserviov1/constants/constants.dart';

class CardsHome extends StatefulWidget {
  final String title;
  final String location;
  final String price;
  final String availability;
  final String imageUrl;

  const CardsHome(
      {required this.title,
      required this.location,
      required this.price,
      required this.availability,
      required this.imageUrl,
      Key? key})
      : super(key: key);

  @override
  State<CardsHome> createState() => _CardsHomeState();
}

class _CardsHomeState extends State<CardsHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 229,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          width: 1,
          color: Colors.black12,
        ),
      ),
      child: Column(
        children: [
          // this container for the image
          Container(
            width: 226,
            height: 130,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.imageUrl), fit: BoxFit.cover),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              // row for the text
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${widget.title}",
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: darkblue,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            ) // Adding style here
                            ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: grayColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.location}',
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: grayColor,
                                    height: 0.10,
                                    letterSpacing: 0.25),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "${widget.price}/Heure",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: blueColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16)),
                        )
                      ],
                    ),
                    Text(
                      "${widget.availability}",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: widget.availability == "disponible"
                                ? Colors.green[500]
                                : Colors.red),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
