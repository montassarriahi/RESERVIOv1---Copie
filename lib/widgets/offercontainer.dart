import 'package:flutter/material.dart';
import 'package:reserviov1/constants/constants.dart';

class OfferContainer extends StatelessWidget {
  final String title;
  final String description;

  OfferContainer({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 400,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: blueColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
