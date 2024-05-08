import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //partie map feha question : reponse
      String welcomeMessage = 'Bonjour! Comment puis-je vous aider?';
  Map<String, String> responses = {
    'Qu\'est-ce que Reservio ?': 'Reservio est une application révolutionnaire qui rend la réservation de salles pour des réunions, des événements et des ateliers aussi simple que de cliquer sur un bouton !',
    'Quelles sont les fonctionnalités principales de Reservio ?': 'Reservio vous offre des fonctionnalités impressionnantes telles que le filtrage et la recherche avancée, un calendrier interactif, des notifications en temps réel, des évaluations et commentaires, ainsi que des images et plans détaillés des salles.',
    'Comment puis-je filtrer les salles avec Reservio ?': 'Vous pouvez filtrer les salles en fonction de critères tels que la capacité, les équipements disponibles, les horaires disponibles et bien plus encore !',
    'Le calendrier interactif est-il facile à utiliser ?': 'Absolument ! Notre calendrier interactif vous permet de visualiser facilement la disponibilité des salles et de réserver en quelques clics seulement.',
    'Reservio envoie-t-il des notifications ?': 'Oui, Reservio envoie des notifications pour vous tenir informé des confirmations de réservation, des rappels de rendez-vous et des mises à jour importantes.',
    'Puis-je laisser des évaluations et des commentaires ?': 'Bien sûr ! Vous pouvez laisser des évaluations et des commentaires sur les salles que vous avez réservées, ce qui aide les autres utilisateurs à trouver la salle parfaite.',
    'Les images et les plans des salles sont-ils disponibles ?': 'Oui, nous fournissons des images et des plans détaillés des salles pour vous donner une meilleure idée de l\'espace avant de faire votre réservation.',
    'Y a-t-il un chat pour discuter avec les propriétaires de salle ?': 'Oui, nous offrons un chat pour que vous puissiez communiquer facilement avec les propriétaires lors de l\'acceptation des demandes de réservation.'
  };

  List<Map<String, dynamic>> conversation = [];
  List<String> currentQuestions = [];
  bool optionSelected = false;

  late ScrollController _scrollController; 

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(); 
    currentQuestions.addAll([
      'Qu\'est-ce que Reservio ?',
      'Quelles sont les fonctionnalités principales de Reservio ?',
      'Comment puis-je filtrer les salles avec Reservio ?',
      'Le calendrier interactif est-il facile à utiliser ?',
      'Reservio envoie-t-il des notifications ?',
      'Puis-je laisser des évaluations et des commentaires ?',
      'Les images et les plans des salles sont-ils disponibles ?',
      'Y a-t-il un chat pour discuter avec les propriétaires de salle ?',
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Bot - Reservio'),
      ),
//--------------generalemnt mafeha maytbadel page hedi jawha behy conv te5dem bel design -------------------
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                welcomeMessage,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                controller: _scrollController, 
                itemCount: conversation.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: conversation[index]['type'] == 'user' ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: conversation[index]['type'] == 'user' ? Color.fromARGB(255, 107, 99, 255) : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: conversation[index]['type'] == 'user'
                              ? Text(
                                  conversation[index]['message'],
                                  style: TextStyle(color: Colors.white),
                                )
                              : TypewriterAnimatedTextKit(
                                  isRepeatingAnimation: false,
                                  speed: Duration(milliseconds: 35),
                                  text: [conversation[index]['message']],
                                  textStyle: TextStyle(color: Colors.black),
                                ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            optionSelected
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            conversation.add({'type': 'bot', 'message': 'Merci pour votre aide !'});
                            optionSelected = false;
                            _scrollToBottom(); 
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color.fromARGB(255, 107, 99, 255)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('Oui'),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            conversation.add({'type': 'bot', 'message': 'Nous allons améliorer notre expérience. Merci pour votre aide !'});
                            optionSelected = false;
                            _scrollToBottom(); 
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color.fromARGB(255, 107, 99, 255)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('Non'),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: currentQuestions.length,
                    itemBuilder: (context, index) {
                      var question = currentQuestions[index];
                      return InkWell(
                        onTap: () {
                          if (responses.containsKey(question)) {
                            String response = responses[question]!;
                            setState(() {
                              conversation.add({'type': 'user', 'message': question});
                              conversation.add({'type': 'bot', 'message': response});
                              currentQuestions.remove(question);
                              _scrollToBottom(); 
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color.fromARGB(255, 107, 99, 255)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(question),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }


  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}