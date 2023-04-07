import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async{

/*  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://jzxyraxbgwnrgkiqmzvl.supabase.co",
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp6eHlyYXhiZ3ducmdraXFtenZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODA1MTYyNjQsImV4cCI6MTk5NjA5MjI2NH0.E5fj_KpW4mG2F2BgaIzeBBqBIozX_xWLZPP_sWcRjEU',
  );*/

  runApp(const NotesListing());
}



class NotesListing extends StatefulWidget {

  const NotesListing({super.key});


  @override
  State<NotesListing> createState() => _NotesListingState();
}

class _NotesListingState extends State<NotesListing> {

  String uuid = "";

  @override
   void initState()  {

    getUuid();

  }

  Future<void> getUuid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uuid = prefs.getString('uuid')!;
  }

  final _notesStream = Supabase.instance.client.from('notes').stream(primaryKey: ['body']);



  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(

        title: const Text("Notes Listing"),

      ),
      body: 
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
              onTap: (){
                Navigator.pushReplacementNamed(context, '/chat');
              },
              child: const Icon(Icons.chat,size: 40,)),
          Expanded(
            child: StreamBuilder<List<Map<String,dynamic>>>(
              stream: _notesStream,
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return const Center(child: CircularProgressIndicator(),);
                }

                final notes = snapshot.data!.where((element) => element['uuid'] == uuid).toList();


                return ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context,index){
                      return ListTile(
                        title: Text(notes[index]['body']),

                      );
                    });
              },

            ),
          ),
        ],
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context, builder: ((context){
            return SimpleDialog(
              title: const Text('Add a Note'),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                TextFormField(onFieldSubmitted: (value) async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                   var uuid = prefs.getString('uuid');
                  await Supabase.instance.client.from('notes').insert({'body': value,'uuid': uuid});


                },),
              ],
            );
          }));
        },
        child: const Icon(Icons.add),
      ),

    );
  }
}
