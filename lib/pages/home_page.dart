import 'package:flutter/material.dart';
import 'package:supabase_table_project/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.sailing_rounded,size: 150,color: Colors.blue,),
          smallGap,
          const Text('Simple App'),
          largeGap,
          OutlinedButton(
              onPressed: (){
            Navigator.pushNamed(context, '/signin');
          }, child: const Text('Sign In')),
          smallGap,
          OutlinedButton(
              onPressed: (){
            Navigator.pushNamed(context, '/signup');
          }, child: const Text('Sign Up')),

        ],
      ),),
    );
  }
}
