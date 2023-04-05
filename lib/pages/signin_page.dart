import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_table_project/constants.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class UserResponse {
  UserResponse({this.authResponse, this.authException, required this.status});

  AuthException? authException;
  AuthResponse? authResponse;
  int status;
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  Future<UserResponse?> userLogin({
    required final String email,
    required final String password,
  }) async {
    UserResponse? response;
    await client.auth
        .signInWithPassword(email: email, password: password)
        .then((value) {
      response = UserResponse(status: 200, authResponse: value);
    }).catchError(( onError) {
log("message ${onError as AuthException}");
      response =
          UserResponse(status: int.parse(response?.authException?.statusCode ??"0"), authException: onError as AuthException);
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.sailing_rounded,
            size: 150,
            color: Colors.blue,
          ),
          largeGap,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(label: Text('Email')),
            ),
          ),
          smallGap,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(label: Text('Password')),
              obscureText: true,
            ),
          ),
          largeGap,
          isLoading
              ? Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : OutlinedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    UserResponse? result = await userLogin(
                        email: _emailController.text,
                        password: _passwordController.text);
                    final user = result?.authResponse?.user;
                    log("USER RESPONSE ${result?.authException?.statusCode}");

                    user?.id;
                    setState(() {
                      isLoading = false;
                    });
                    if (result?.authException?.statusCode == "400") {
                      context.showErrorMessage('Invalid Email or Password!');
                    } else {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString('uuid', result?.authResponse?.user?.id??"");
                      Navigator.pushReplacementNamed(context, '/noteslisting');

                    }
                  },
                  child: const Text('Sign In'),
                ),
        ],
      ),
    );
  }
}
