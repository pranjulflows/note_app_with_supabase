// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str),"");

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
     this.id,
     this.content,
     this.markAsRead,
     this.userFrom,
     this.userTo,
     this.createdAt,
  });

  dynamic id;
  String? content;
  String? markAsRead;
  String? userFrom;
  String? userTo;
  String? createdAt;

  factory Message.fromJson(Map<String, dynamic> json, String currentUserId) => Message(
    id: json["id"],
    content: json["content"],
    markAsRead: json["mark_as_read"],
    userFrom: json["user_from"],
    userTo: json["user_to"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "mark_as_read": markAsRead,
    "user_from": userFrom,
    "user_to": userTo,
    "created_at": createdAt,
  };
}



/*class Message {
  final dynamic id;
  final String? content;
  final bool? markAsRead;
  final String? userFrom;
  final String? userTo;
  final String? createAt;
  final bool? isMine;

  Message({
    required this.id,
    required this.content,
    required this.markAsRead,
    required this.userFrom,
    required this.userTo,
    required this.createAt,
    required this.isMine
  });

  Message.create(
      {required this.content, required this.userFrom, required this.userTo})
      : id = dynamic,
        markAsRead = false,
        isMine = true,
        createAt = "";

  Message.fromJson(Map<String,dynamic> json, String userId)
      : id = json['id'],
        content = json['content']??"",
        markAsRead = json['mark_as_read']??false,
        userFrom = json['user_from']??"",
        userTo = json['user_to']??"",
        createAt = json['created_at']??"",
        isMine = json['user_from'] == userId??false;

  Map toMap(){
    return{
      'content' : content,
      'user_from' : userFrom,
      'user_to' : userTo,
       'mark_as_read' : markAsRead

    };
  }

}*/
