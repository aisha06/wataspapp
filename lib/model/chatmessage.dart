import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}

class Message {
  late String senderId;
  late String senderEmail;
  late String recieverId;
  late String message;
  late String timeStamps;
  Message(
      {required this.message,
      required this.recieverId,
      required this.timeStamps,
      required this.senderEmail,
      required this.senderId});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'recieverId': recieverId,
      'message': message,
      'timeStamps': timeStamps,
    };
  }
}
