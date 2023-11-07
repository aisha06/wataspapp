import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/chatmessage.dart';

class InboxView extends StatelessWidget {
  String recieveremail;
  String recieverUid;

  InboxView(
      {super.key, required this.recieverUid, required this.recieveremail}) {
    // TODO: implement InboxView
  }
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController messagecontroller = TextEditingController();
  void sendMessag() {
    if (messagecontroller.text.isNotEmpty) {
      sendmessage(recieverUid, messagecontroller.text);
      messagecontroller.clear();
    }
  }

  Future<void> sendmessage(String recieverId, String message) async {
    final String createUserId = _firebaseAuth.currentUser!.uid;
    final String createUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamps = Timestamp.now();
    Message newMessage = Message(
        message: message,
        recieverId: recieverId,
        senderId: createUserId,
        timeStamps: timestamps.toString(),
        senderEmail: createUserEmail);

    List ids = [createUserId, recieverId];
    ids.sort();
    String chatroomIds = ids.join("");
    await FirebaseFirestore.instance
        .collection('chats_room')
        .doc(chatroomIds)
        .collection(message)
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessgae(
      String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatroomId = ids.join("");
    log('${chatroomId}');
    return FirebaseFirestore.instance
        .collection('chats_room')
        .doc(chatroomId)
        .collection('message')
        .orderBy('timeStamps', descending: false)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          radius: 4.0,
        ),
        title: Text(recieveremail),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          StreamBuilder(
            stream: getMessgae(recieverUid, _firebaseAuth.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<DocumentSnapshot<Map<String, dynamic>>> documents =
                    snapshot.data!.docs;
                log('-----------22222222${snapshot.data}');
                return ListView(
                children:  snapshot.data!.docs
                    .map((documents) => _builmessageItems(documents))
                    .toList());
              } else {
                return Center(child: Text("${snapshot.error}"));
              }
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      sendMessag();
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListView _builmessageItems(DocumentSnapshot document) {
    return ListView.builder(
      itemCount: messages.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        return Container(
          padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
          child: Align(
            alignment: (data['senderId'] == _firebaseAuth.currentUser!.uid
                ? Alignment.topLeft
                : Alignment.topRight),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: (messages[index].messageType == "receiver"
                    ? Colors.grey.shade200
                    : Colors.blue[200]),
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                data["message"]??"",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        );
      },
    );
  }
}
