import 'package:contact_app/models/contacts.dart';
import 'package:contact_app/screens/add_contact.dart';
import 'package:contact_app/screens/contact_detail.dart';
import 'package:contact_app/screens/contact_list.dart';
import 'package:flutter/material.dart';
import './screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
   

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact App',
      theme: ThemeData(
         
        primarySwatch: Colors.deepOrange,
      ),
      home: const HomeScreen(),
      routes: {
        AddContact.routName:(context) =>const AddContact(),
        ContactList.routname:(context) =>  ContactList(),
        
      },
    );
  }
}
