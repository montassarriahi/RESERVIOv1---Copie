import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:reserviov1/widgets/HoriCard.dart';

import 'package:reserviov1/constants/constants.dart';

class CardTest extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String location;
  final String price;
  final String rating;
  const CardTest(
      {required this.title,
      required this.location,
      required this.price,
      required this.rating,
      required this.imageUrl});

  @override
  State<CardTest> createState() => _CardTestState();
}

class _CardTestState extends State<CardTest> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 103,
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.5, color: grayColor),
              borderRadius: BorderRadius.circular(22))),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // first row
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 105,
                  height: 78,
                  decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.imageUrl),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.title}",
                      style: TextStyle(
                          color: darkblue,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          height: 0.09,
                          letterSpacing: 0.15),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                              color: grayColor,
                            ),
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
              ],
            ),

            // sec row
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: '${widget.rating}',
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                          color: Color(0xFFFFB24D),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ))),
                    const WidgetSpan(
                        child: Icon(Icons.star_rate_rounded,
                            size: 20, color: Color(0xFFFFB24D))),
                  ],
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
