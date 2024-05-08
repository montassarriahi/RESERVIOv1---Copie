import 'package:flutter/material.dart';

TextTheme buildCustomTextTheme(BuildContext context) {
  return TextTheme(
    // Define display text styles
    displayLarge: TextStyle(
      fontFamily: 'Roboto',
      fontSize: Theme.of(context).textTheme.displayLarge!.fontSize,
      color: Theme.of(context).colorScheme.primary,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Roboto',
      fontSize: Theme.of(context).textTheme.displayMedium!.fontSize! * 0.8,
      color: Colors.black87,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Roboto',
      fontSize: Theme.of(context).textTheme.displaySmall!.fontSize! * 0.7,
      color: Colors.grey[600],
    ),

    // Define headline text styles
    headlineLarge: TextStyle(
      fontFamily: 'Roboto',
      fontSize: Theme.of(context).textTheme.headlineLarge!.fontSize,
      color: Theme.of(context).colorScheme.primary,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Roboto',
      fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize! * 0.8,
      color: Colors.black87,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Roboto',
      fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize! * 0.7,
      color: Colors.grey[600],
    ),

    // Define title text styles
    titleLarge: TextStyle(
      fontFamily: 'Roboto',
      fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
      color: Colors.black87,
    ),

    // Define body text styles
    bodyText1: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16.0,
      color: Colors.black87,
    ),
    bodyText2: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 14.0,
      color: Colors.grey[600],
    ),

    // Define label text styles
    labelLarge: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 14.0,
      color: Colors.grey[600],
    ),
    labelMedium: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 12.0,
      color: Colors.grey[600],
    ),

    // Include button and caption styles (optional)
    button: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 14.0,
      color: Theme.of(context).colorScheme.primary,
    ),
    caption: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 12.0,
      color: Colors.grey[600],
    ),
  );
}
