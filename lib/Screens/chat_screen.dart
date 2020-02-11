import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:real_chat/utilities/constants.dart';

class ChatScreen extends StatefulWidget {
  static final String id = "ChatScreen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  final _fireStore = Firestore.instance;
  String messageText;
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  // This Function To get Email Of Current User Once logged In Chat Screen

  void getCurrentUser() async {
    try {
      final currentUser = await _auth.currentUser();
      if (currentUser != null) {
        loggedInUser = currentUser;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("chats"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          StreamBuilder(
            stream: _fireStore.collection("messages").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blueAccent,
                  ),
                );
              }

              final messages = snapshot.data.documents.reversed;
              List<Chats> msgs = [];
              for (var message in messages) {
                final messageText = message.data["text"];
                final messageSender = message.data["sender"];
                final currentUser = loggedInUser.email;
                final msges = Chats(
                  text: messageText,
                  email: messageSender,
                  me: currentUser == messageSender,
                );
                msgs.add(msges);
              }
              return Expanded(
                child: ListView(
                  reverse: true,
                  children: msgs,
                ),
              );
            },
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    messageText = value;
                  },
                  controller: _controller,
                  decoration: kTextFieldChat,
                ),
              ),
              FlatButton(
                onPressed: () {
                  _controller.clear();
                  _fireStore.collection("messages").add(
                    {
                      "sender": loggedInUser.email,
                      'text': messageText,
                    },
                  );
                },
                child: Text("Send", style: kSendButtonStyle),
              )
            ],
          )
        ],
      ),
    );
  }
}

class Chats extends StatelessWidget {
  final String text, email;
  final bool me;
  Chats({this.text, this.email, this.me});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            email,
            style: TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Material(
              borderRadius: BorderRadius.circular(20.0),
              color: me ? Colors.blueAccent : Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 20.0),
                child: Text(text),
              ),
            ),
          )
        ],
      ),
    );
  }
}
