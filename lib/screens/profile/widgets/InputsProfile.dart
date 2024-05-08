import 'package:flutter/material.dart';

class InputsProfile extends StatelessWidget {
  final String Labels;
  final String InitValue;

  const InputsProfile({
    Key? key, // Add Key? key parameter
    required this.Labels,
    required this.InitValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: InitValue,
      readOnly: true,
      decoration: InputDecoration(
        labelText: Labels,
        border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 255, 0, 0), width: 0.5)),
      ),
    );
  }
}
