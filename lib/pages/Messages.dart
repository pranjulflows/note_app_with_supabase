// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    required this.id,
    required this.markAsRead,
    required this.userFrom,
    required this.userTo,
    required this.createdAt,
  });

  String id;
  String markAsRead;
  String userFrom;
  String userTo;
  String createdAt;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    markAsRead: json["mark_as_read"],
    userFrom: json["user_from"],
    userTo: json["user_to"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mark_as_read": markAsRead,
    "user_from": userFrom,
    "user_to": userTo,
    "created_at": createdAt,
  };
}
