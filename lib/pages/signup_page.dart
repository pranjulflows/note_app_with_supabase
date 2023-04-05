import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:supabase_table_project/constants.dart';


class SignUpPage extends StatefulWidget {
   const SignUpPage({Key? key}) : super(key: key);



  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String error = "";
  Future<bool> createUser({
    required final String email,
    required final String password,
}) async{
    final response =  await client.auth.signUp(email: email,password: password).catchError((onError){
      print(onError);
      error=onError.toString();
    });
    if(error.isEmpty){
      return true;
    }else{
      return false;
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.sailing_rounded,
            size: 150,
              color: Colors.blue,
            ),
            largeGap,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  label: Text('Email')
                ),
              ),
            ),
            smallGap,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  label: Text('Password'),
                ),
                obscureText: true,
              ),
            ),
            largeGap,
            OutlinedButton(onPressed: () async{
              final userValue = await createUser(email: _emailController.text, password: _passwordController.text);
              if(userValue == true){
                Navigator.pushReplacementNamed(context, '/signin');
                context.showErrorMessage('Success');

              }
            }, child: const Text('Sign Up')),

          ],
        ),
      ),
    );
  }
}
