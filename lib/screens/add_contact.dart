import 'package:contact_app/db/database_helper.dart';
import 'package:contact_app/models/contacts.dart';
import 'package:contact_app/screens/contact_list.dart';
import 'package:flutter/material.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key}) : super(key: key);
  static const routName='/add-contact';

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  late String name;
  late int number;
  late String email;
  final _numberNode = FocusNode();
  final _emailNode = FocusNode();
  final _formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                validator: (String?value) {
                  if (value==null ||value.isEmpty) {
                    return 'Please provide contact name';
                  }
                  name=value;
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter name',
                  labelText: 'Name',
                  labelStyle: const TextStyle(fontSize: 20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_numberNode);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType:TextInputType.phone,
                validator: (String?value) {
                  if (value==null ||value.isEmpty) {
                    return 'Please provide contact number';
                  }
                  number=int.parse(value);
                  return null;
                },
                focusNode: _numberNode,
                decoration: InputDecoration(
                  hintText: 'Enter number',
                  labelText: 'Number',
                  labelStyle: const TextStyle(fontSize: 20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_emailNode);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (String?value) {
                  if (value==null ||value.isEmpty) {
                    return 'Please provide contact email';
                  }
                  email=value;
                  return null;
                },
                focusNode: _emailNode,
                decoration: InputDecoration(
                  hintText: 'Enter email',
                  labelText: 'Email',
                  labelStyle: const TextStyle(fontSize: 20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async{
                  if (_formKey.currentState!.validate()) {
                    var contacts=Contacts(name: name, email: email, number: number);
                    var dbHelper=DatabaseHelper.instance;
                    int result=  await dbHelper.saveContact(contacts);
                    if (result>0) {
                      Navigator.pop(context);
                      print('data saved');
                      Navigator.of(context).pushNamed(ContactList.routname);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Create New Contact',
                  style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
