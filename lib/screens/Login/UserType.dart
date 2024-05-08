import 'package:flutter/material.dart';
import 'package:reserviov1/screens/Login/RequestAcess.dart';
import 'package:reserviov1/widgets/button.dart';

class UsersType extends StatefulWidget {
  const UsersType({super.key});

  @override
  State<UsersType> createState() => _UsersTypeState();
}

class _UsersTypeState extends State<UsersType> {
  String? role;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Continuer en tant que",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ImageTextButton(
                    buttonText: "Propriétaires",
                    imagePath: "assets/images/Propriétaires.svg",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RequestAcess(
                                    role: "Propriétaires",
                                  )));
                    },
                  ),
                  ImageTextButton(
                    buttonText: "Réservataires",
                    imagePath: "assets/images/reservataire.svg",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RequestAcess(role: "client")));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
