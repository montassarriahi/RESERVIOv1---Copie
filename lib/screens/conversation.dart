import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reserviov1/constants/constants.dart';

class ConversationPage extends StatefulWidget {
  final String reservationId;
  final String currentUser;

  ConversationPage({required this.reservationId, required this.currentUser});

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  //----------------hedi page convertation ma3andek matbadel feha zeda jawha behi -------------------
  TextEditingController _messageController = TextEditingController();
  List<String> _conversation = [];

  @override
  void initState() {
    super.initState();

    loadConversation();
  }


  void loadConversation() async {
    DocumentSnapshot reservationSnapshot = await FirebaseFirestore.instance.collection('reservation').doc(widget.reservationId).get();
    Map<String, dynamic> reservationData = reservationSnapshot.data() as Map<String, dynamic>;
    setState(() {
      _conversation = List<String>.from(reservationData['conversation'] ?? []);
    });
  }

  
  void addMessageToFirestore(String message) {
    FirebaseFirestore.instance.collection('reservation').doc(widget.reservationId).update({
      'conversation': FieldValue.arrayUnion([message]),
    });
  }

 
  void sendMessage(String message) {
    if (message.isNotEmpty) {
      String formattedMessage = "${widget.currentUser}: $message";
      setState(() {
        _conversation.add(formattedMessage);
        _messageController.clear();
      });
      addMessageToFirestore(formattedMessage);
    }
  }

 
  Widget buildConversationList() {
    return ListView.builder(
      itemCount: _conversation.length,
      itemBuilder: (context, index) {
        String message = _conversation[index];
        bool isCurrentUser = message.startsWith(widget.currentUser);
        return buildMessageBubble(message, isCurrentUser);
      },
    );
  }


 Widget buildMessageBubble(String message, bool isCurrentUser) {
  return Row(
    mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
    children: [
      Container(
        constraints: BoxConstraints(maxWidth: 250.0),
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isCurrentUser ? blueColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          message.split(':').length > 1 ? message.split(':')[1].trim() : message,
          textAlign: isCurrentUser ? TextAlign.right : TextAlign.left, 
          softWrap: true, 
          style: TextStyle(
            color: isCurrentUser ? Colors.white : Colors.black,
            fontSize: 16.0,
          ),
        ),
      ),
    ],
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversation"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildConversationList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    sendMessage(_messageController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
