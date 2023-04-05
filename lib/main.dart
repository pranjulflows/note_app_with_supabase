import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_table_project/constants.dart';
import 'package:supabase_table_project/pages/home_page.dart';
import 'package:supabase_table_project/pages/notes_listing.dart';
import 'package:supabase_table_project/pages/signin_page.dart';
import 'package:supabase_table_project/pages/signup_page.dart';
import 'package:supabase_table_project/pages/simpleapp_page.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://jzxyraxbgwnrgkiqmzvl.supabase.co",
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp6eHlyYXhiZ3ducmdraXFtenZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODA1MTYyNjQsImV4cCI6MTk5NjA5MjI2NH0.E5fj_KpW4mG2F2BgaIzeBBqBIozX_xWLZPP_sWcRjEU',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: client.auth.currentSession != null ? '/simpleapp' : '/',

      routes: {
        '/' : (context) => const HomePage(),
        '/signin':(context) => const SignInPage(),
        '/signup':(context) => const SignUpPage(),
        '/simpleapp':(context) => const SimpleAppPage(),
        '/noteslisting':(context) => const NotesListing(),

      },

    );
  }
}

/*class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _notesStream = Supabase.instance.client.from('notes').stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: StreamBuilder<List<Map<String,dynamic>>>(
        stream: _notesStream,
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator(),);
          }
          final notes = snapshot.data!;

          return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context,index){
                return ListTile(
                  title: Text(notes[index]['body']),
                );
              });
        },

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context, builder: ((context){
            return SimpleDialog(
              title: Text('Add a Note'),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                TextFormField(onFieldSubmitted: (value) async{
                  await Supabase.instance.client.from('notes').insert({'body': value});

                },),
              ],
            );
          }));
        },
        child: const Icon(Icons.add),
      ),

    );
  }*/

