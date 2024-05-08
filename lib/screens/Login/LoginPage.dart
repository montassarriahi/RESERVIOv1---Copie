import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:reserviov1/constants/constants.dart';

import 'package:reserviov1/logic/AuthLogin/AuthLogin_bloc.dart';

import 'package:reserviov1/screens/Bottom.dart';

import 'package:reserviov1/screens/Login/UserType.dart';
import 'package:reserviov1/screens/Login/firebaseAuth/FirebaseAuthServices.dart';
import 'package:reserviov1/screens/dashbord/dashbord.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthLoginBloc(),
      child: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberme = false;
  bool passwordToggle = true;

  final FirebaseAuthServices _auth = FirebaseAuthServices();

  // firebase function auth
  void SignIn() async {
    String Loginemail = emailController.text;
    String LoginPassword = passwordController.text;
    User? user =
        await _auth.signInWithEmailAndPassword(Loginemail, LoginPassword);

    if (user != null) {
      String userId = user.uid;
      print('User loged successfully with UID: $userId');

      // this one to get user doc from firestore

      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('user').doc(userId).get();

      // get data as map (dict in python)
      Map<String, dynamic>? Data = userSnapshot.data() as Map<String, dynamic>;

      // check if user exist and get respo
      if (userSnapshot.exists && (Data)['verifier'] == true) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => bar()), (route) => false);
      }
      // verif = false
      else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('please verify your account'),
          backgroundColor: Colors.red,
        ));
      }

      //user not exist message
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('User not exist'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    addListenerToController();
  }

  addListenerToController() {
    emailController.addListener(() {
      context
          .read<AuthLoginBloc>()
          .add(AuthLoginEvent.emailChanged(emailController.text));
    });
    passwordController.addListener(() {
      context
          .read<AuthLoginBloc>()
          .add(AuthLoginEvent.passChanged(passwordController.text));
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthLoginBloc, AuthloginState>(
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
                    children: [
                      Text('Logo'),
                    ],
                  ),
                  SizedBox(height: 63),
                  Row(
                    children: [
                      Text(
                        'Se Connecter',
                        style: GoogleFonts.roboto(
                          color: blueColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 338,
                        child: Text(
                          'Connectez-vous rapidement à Reservio pour accéder à vos réservations et profiter d\'une planification sans effort. Bienvenue de retour !',
                          style: GoogleFonts.roboto(
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 33),
                  Row(
                    children: [
                      Container(
                          width: 360,
                          child: Form(
                              child: Column(children: [
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                errorText: state.email.displayError != null
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
                            SizedBox(height: 8),
                            TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                errorText: state.pass.displayError != null
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
                  SizedBox(height: 22),
                  Row(
                    children: [
                      Switch(
                        value: rememberme,
                        activeColor: blueColor,
                        onChanged: (bool value) {
                          setState(() {
                            rememberme = value;
                          });
                        },
                      ),
                      Text('Se souvenir de moi',
                          style: GoogleFonts.roboto(
                            color: darkblue,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          )),
                    ],
                  ),
                  SizedBox(height: 80),
                  Row(
                    children: [
                      SizedBox(
                        width: 360,
                        height: 56,
                        child: ElevatedButton(
                            onPressed: () {
                              if (state.isValid) {
                                SignIn();
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => LoginInContent(
                                //           userEmail: state.email.value)),
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => bar()),
                                // );

                                // Navigator.pushAndRemoveUntil(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => bar()),
                                //     (route) => false);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
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
                            child: Text("Connecter")),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(59, 17, 0, 0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => UsersType()));
                          },
                          child: Text('Pas de compte ? creer un compte !'),
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
