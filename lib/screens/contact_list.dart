import 'package:contact_app/db/database_helper.dart';
import 'package:contact_app/models/contacts.dart';
import 'package:contact_app/screens/contact_detail.dart';
import 'package:flutter/material.dart';

class ContactList extends StatefulWidget {
  
   ContactList({Key? key,}) : super(key: key);
  static const routname= '/contact-list';

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  
  
  
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
      
        title: const Text('Contacts List'),
      ),
      body: FutureBuilder<List<Contacts>>(
        future:  DatabaseHelper.instance.getAllContacts(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('No data saved yet'),);
            }
            else{
              List <Contacts>contacts=snapshot.data!;

              return Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              'Contacts',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                Contacts contact=contacts[index];
                return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: const Color.fromARGB(255, 246, 220, 185),
                margin: const EdgeInsets.all(5),
                child:  ListTile(
                   onTap: ()async {
                    
                    var result=await Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return ContactDetail(ctx: contact,);
                        }));

                        if (result=='done') {
                          setState(() {
                            
                          });
                        }
                   } ,
                  leading: CircleAvatar(
                    radius: 30,
                    child: Text(
                      contact.name[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(contact.name),
                  subtitle: Text(contact.number.toString()),
                ),
              );
              },
            ),
          ),
        ],
      );
            }
          }
          else{
            return const Center(child: CircularProgressIndicator(),);
          }
        }
        ),
    );
  }
}
