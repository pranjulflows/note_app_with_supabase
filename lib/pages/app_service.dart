import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_table_project/pages/message.dart';

class AppService extends ChangeNotifier {
  final _supabase = Supabase.instance.client;
  final _password = "hfdgfjhgjfhgj";

  Future<void> _createUser(int i) async {
    final response = await _supabase.auth
        .signUp(email: 'test_$i@test.com', password: _password);

    await _supabase
        .from('contact')
        .insert({'id': response.user!.id, 'username': 'User $i'}).execute();
  }

 /* Future<void> createUsers() async {
    await _createUser(1);
    await _createUser(1);
  }

  Future<void> signIn(int i) async {
    await _supabase.auth
        .signInWithPassword(email: 'test_$i@test.com', password: _password);
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }*/

  Future<String> _getUserTo() async {
    final response = await _supabase
        .from('messages')
        .select('user_to')
        .not('user_to', 'eq', getCurrentUserId())
        .execute();

    return response.data[0]['user_to'];

  }

/*geMessages() async {
   await _supabase
      .from('messages')
      .stream(primaryKey: ['user_id'])
      .order('user_from')
      .toList()
      .then((value) {
    log("messagewewewewew $value");
  })
      .catchError((onError) {
    log("FUTURE ERROR $onError");
  });
}*/


  Stream<List<Message>> getMessages() {

/*    var messages = _supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('inserted_at').toList().then((value) {

      log("message  $value");

    });*/
String userId = getCurrentUserId();
log("userIDDDD $userId");

    var messages = _supabase
        .from('messages')
        .stream(primaryKey: ['user_from'])
        .order('user_from')
        .map((maps) => maps
            .map((item) => Message.fromJson(item, getCurrentUserId()))
            .toList());
    messages.listen((event) {
      log("fgfgfgh ${jsonEncode(event)}");
    });

    return messages;
  }

  Future<void> saveMessage(String content) async {
    final userTo = await _getUserTo();

    final message = Message(content: content, userFrom: getCurrentUserId(), userTo: userTo,);

/*    final message = Message.create(
        content: content, userFrom: getCurrentUserId(), userTo: userTo);*/

    await _supabase.from('messages').insert(message.toJson());
  }

  bool isAuthentificated() => _supabase.auth.currentUser != null;

   String getCurrentUserId() =>
      isAuthentificated() ? _supabase.auth.currentUser!.id : "";

  String getCurrentUserEmail() =>
      isAuthentificated() ? _supabase.auth.currentUser!.email ?? "" : "";
}
