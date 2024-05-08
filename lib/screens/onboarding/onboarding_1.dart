import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reserviov1/constants/constants.dart';
import 'package:reserviov1/screens/Login/LoginPage.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingOne extends StatefulWidget {
  const OnboardingOne({super.key});

  @override
  State<OnboardingOne> createState() => _OnboardingOneState();
}

class _OnboardingOneState extends State<OnboardingOne> {
  final PageController _pageController = PageController(initialPage: 0);

  

  int _currentPageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void TonextPage() {
    if (_currentPageIndex < 2) {
      _pageController.nextPage(
          duration: Duration(milliseconds: 600), curve: Curves.ease);
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentPageIndex = index;
        });
      },
      children: [
        Pages("assets/images/onboarding1.svg", " Bienvenue dans Reservio",
            " Découvrez une nouvelle façon de simplifier la réservation de salles pour vos réunions, événements et ateliers "),
        Pages("assets/images/office.svg", "Trouvez l'espace idéal",
            "Avec Reservio, trouvez l'espace parfait, planifiez sans effort et organisez des rencontres mémorables."),
        Pages("assets/images/onboarding1.svg", "Inscrivez-vous ",
            "Rejoignez la communauté Reservio  en quelques étapes simples. "),
      ],
    );
  }

  Widget Pages(String img, String Title, String description) {
    return Container(
      child: Scaffold(
        body: SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              SizedBox(
                height: 128,
              ),
              Expanded(
                child: Container(
                  child: SvgPicture.asset(
                    img,
                    width: 250,
                  ),
                ),
              ),

              // Image.asset("assets/images/search.png"),
              SizedBox(
                height: 50,
              ),
              Text(
                Title,
                style: GoogleFonts.roboto(
                    fontSize: 22, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 60),
                child: Text(description,
                    textAlign: TextAlign.center, style: DescriptionText),
              ),
              SizedBox(
                height: 89,
              ),
              SizedBox(
                width: 343,
                height: 56,
                child: ElevatedButton(
                    onPressed: () {
                      TonextPage();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: blueColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: Text("Suivant")),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text(
                        "Passer",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Colors.black),
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: blueColor,
                    dotHeight: 10,
                    dotWidth: 10,
                  ))

              // DotsIndicator(
              //   dotsCount: 3,
              //   decorator: DotsDecorator(
              //       activeColor: blueColor,
              //       color: Colors.grey,
              //       activeSize: Size(30, 10),
              //       activeShape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(100))),
              // )
            ]),
          ),
        )),
      ),
    );
  }
}
