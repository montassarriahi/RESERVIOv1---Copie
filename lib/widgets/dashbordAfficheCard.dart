import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  
  final String title;
  
  final VoidCallback onTap;

  const CardInfo({
    Key? key,
    
    required this.title,
    
    required this.onTap,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
         color: Colors.blue[100],
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
             
            ],
          ),
        ),
      ),
    );
  }
}