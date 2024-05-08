import 'package:flutter/material.dart';
import 'package:reserviov1/constants/constants.dart';

class PassToggler extends StatefulWidget {
  final String PasswordText;

  const PassToggler({required this.PasswordText});

  @override
  State<PassToggler> createState() => _PassTogglerState();
}

class _PassTogglerState extends State<PassToggler> {
  bool ShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.PasswordText,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Password',
        border: const OutlineInputBorder(),
        suffix: InkWell(
          onTap: () {
            setState(() {
              ShowPassword = !ShowPassword;
            });
          },
          child: Icon(
              color: ShowPassword ? Colors.grey : blueColor,
              ShowPassword ? Icons.visibility_off : Icons.visibility),
        ),
      ),
      obscureText: ShowPassword,
    );
  }
}
