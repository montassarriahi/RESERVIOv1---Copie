import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reserviov1/constants/constants.dart';
import 'package:reserviov1/logic/Request/Request_bloc.dart';
import 'package:reserviov1/screens/Login/LoginPage.dart';
import 'package:reserviov1/screens/Login/firebaseAuth/FirebaseAuthServices.dart';
import 'package:reserviov1/widgets/Alertdialogue.dart';

class Request extends StatelessWidget {
  Request();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestBloc(),
      child: RequestAcess(),
    );
  }
}

class RequestAcess extends StatefulWidget {
  final String? role;

  RequestAcess({Key? key, this.role}) : super(key: key);

  @override
  State<RequestAcess> createState() => _RequestAcessState();
}

class _RequestAcessState extends State<RequestAcess> {
  final TextEditingController emailSigningController = TextEditingController();
  final TextEditingController passwordSigningController =
      TextEditingController();

  final TextEditingController UserNameController = TextEditingController();

  bool rememberme = false;
  bool passwordToggle = true;
// Auth with firebase
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  void _Signup() async {
    String UserName = UserNameController.text;
    String email = emailSigningController.text;
    String password = passwordSigningController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      String userId = user.uid;
      print('User created successfully with UID: $userId');
      addUser(userId, UserName, email, password);
    } else {
      print("some error");
    }
  }

  @override
  void initState() {
    super.initState();
    addListenerToController();
  }

  addListenerToController() {
    emailSigningController.addListener(() {
      context
          .read<RequestBloc>()
          .add(RequestEvent.emailChanged(emailSigningController.text));
    });
    passwordSigningController.addListener(() {
      context
          .read<RequestBloc>()
          .add(RequestEvent.passChanged(passwordSigningController.text));
    });
  }

  @override
  void dispose() {
    emailSigningController.dispose();
    passwordSigningController.dispose();
    UserNameController.dispose();
    super.dispose();
  }

  void addUser(
      String userId, String UserName, String email, String Pass) async {
    await FirebaseFirestore.instance.collection("user").doc(userId).set({
      'email': email,
      'pass': Pass,
      'username': UserName,
      'verifier': false,
      'role': widget.role
    });
  }

  void Fermer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestBloc, RequestState>(
      builder: (context, state) {
        return Scaffold(
            body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 31, 0, 0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [SvgPicture.asset("assets/images/full logo.svg")],
                  ),
                  SizedBox(height: 63),
                  Row(
                    children: [
                      Text(
                        "S'inscrire",
                        style: GoogleFonts.roboto(
                          color: blueColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 338,
                        child: Text(
                          'Entrez vos donner ci-dessous, pour commencer à explorer et réserver les salles ',
                          style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Row(
                    children: [
                      Container(
                          width: 360,
                          child: Form(
                              child: Column(children: [
                            // UserName
                            TextFormField(
                              controller: UserNameController,
                              decoration: InputDecoration(
                                // errorText: state.emailS.displayError != null
                                //     ? 'invalid email'
                                //     : null,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.8),
                                    )),
                                hintText: 'Username',
                              ),
                            ),
                            SizedBox(height: 8),
                            // email
                            TextFormField(
                              controller: emailSigningController,
                              decoration: InputDecoration(
                                errorText: state.emailS.displayError != null
                                    ? 'invalid email'
                                    : null,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.8),
                                    )),
                                hintText: 'Adresse mail',
                              ),
                            ),
                            SizedBox(height: 16),

                            // password
                            TextFormField(
                              controller: passwordSigningController,
                              decoration: InputDecoration(
                                errorText: state.passS.displayError != null
                                    ? 'invalid password'
                                    : null,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.8),
                                    )),
                                hintText: 'Mot de passe',
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      passwordToggle = !passwordToggle;
                                    });
                                  },
                                  child: Icon(
                                      //color: Colors.indigo,
                                      color: passwordToggle
                                          ? Colors.grey
                                          : blueColor,
                                      passwordToggle
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                ),
                              ),
                              obscureText: passwordToggle,
                            )
                          ]))),
                    ],
                  ),
                  SizedBox(height: 160),
                  Row(
                    children: [
                      SizedBox(
                        width: 360,
                        height: 56,
                        child: ElevatedButton(
                            onPressed: () {
                              if (state.isValid) {
                                _Signup();

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Aletdialogue(
                                        "Demande envoyée",
                                        "Félicitations ! Votre demande d'inscription a été envoyée avec succès. Nous sommes ravis de vous accueillir dans la communauté Reservio . Veuillez vérifier votre boîte de réception. Nous vous avons envoyé vos informations de connexion.",
                                        "Fermer",
                                        Icons.mobile_friendly,
                                        Fermer);
                                  },
                                );
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text('verifier votre Compte '),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: blueColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            child: Text(
                              "Envoyer une demande",
                              style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.15)),
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(105, 8, 0, 0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => LoginPage()));
                          },
                          child: Text(
                            'J\'ai un compte deja !',
                            style: TextStyle(color: blueColor),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
