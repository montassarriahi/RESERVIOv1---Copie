import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:reserviov1/constants/constants.dart';

class HorizCard extends StatelessWidget {
  const HorizCard({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Container(
            width: width,
            height: 103,
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: grayColor),
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
                            image: const DecorationImage(
                              image: NetworkImage(
                                  'https://images.unsplash.com/photo-1542744173-8e7e53415bb0?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
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
                            "Premeium espace",
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
                                'location',
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
                            "20/Heure",
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
                              text: '4',
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
          ),
        ),
      ),
    );
  }
}
