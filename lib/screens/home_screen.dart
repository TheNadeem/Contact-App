import 'package:contact_app/screens/add_contact.dart';
import 'package:contact_app/screens/contact_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 211, 163),
      appBar: AppBar(
        title: const Text('Contact App'),
      ),
      body:
      Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Center(
              child: Expanded(
                child: Image.asset(
                          'assets/images/contact1.png',
                          height: 350,
                        ),
              )),
          const SizedBox(height:30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(130, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(AddContact.routName);
            },
            child: const Text(
              'Add Contact',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 10,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(130, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(ContactList.routname);
            },
            child: const Text(
              'Contacts List',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
            ],
          ),
        ],
      ),
    );
  }
}
