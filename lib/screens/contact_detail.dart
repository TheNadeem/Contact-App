

import 'package:contact_app/models/contacts.dart';
import 'package:contact_app/screens/contact_list.dart';
import 'package:contact_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../db/database_helper.dart';

class ContactDetail extends StatefulWidget {

  final Contacts ctx;
  const ContactDetail({Key? key,required this.ctx}) : super(key: key);
  

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  late String name;
  late int number;
  late String email;
 
  final _numberNode = FocusNode();
  final _emailNode = FocusNode();
  bool isVisible=false;
  final _formKey = GlobalKey<FormState>();

  
  @override
  Widget build(BuildContext context) {
    
      
    return Scaffold(
      
      appBar: AppBar(
        
        title: Text(widget.ctx.name),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
           Center(
            child: Text(
              widget.ctx.name,
              style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
           Center(
            child: Text(
              widget.ctx.number.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              widget.ctx.email,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.call,
                  size: 45,
                  color: Colors.orange,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.mail,
                  size: 45,
                  color: Colors.orange,
                ),
              ),
              IconButton(
                onPressed: () {
                 
                  setState(() {
                    isVisible=!isVisible;
                  });
                },
                icon: const Icon(
                  Icons.edit,
                  size: 45,
                  color: Colors.orange,
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context, builder: (context){
                      return AlertDialog(
                        title: const Text('Confirmation'),
                        content: const Text('Want to delete ?'),
                        actions: [
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                             child: const Text('No'),
                             ),
    
                              TextButton(
                            onPressed: () async{
                               Navigator.pop(context);
                               int result = await DatabaseHelper.instance.deleteContact(widget.ctx);
                               if (result>0) {
                     
                                  setState(() {
                                    Navigator.pop(context,'done');
                                  });
                                }
                            },
                             child: const Text('Yes'),
                             ),
                        ],
                      ); 
                    }
                    );
                },
                icon: const Icon(
                  Icons.delete,
                  size: 45,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30,),
          Expanded(
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Visibility(
                  visible: isVisible,
                  child: Form(
                    key: _formKey,
                            child: ListView(
                  children: [
                    const SizedBox(height: 10,),
                    TextFormField(
                      validator: (String?value) {
                  if (value==null ||value.isEmpty) {
                    return 'Please provide contact name';
                  }
                  name=value;
                  return null;
                },
                      initialValue:widget.ctx.name,
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
                    initialValue: widget.ctx.number.toString(),
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
                    initialValue: widget.ctx.email,
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
                        var contact=Contacts(id:widget.ctx.id ,name: name, email:email, number: number);

        
                     int result= await DatabaseHelper.instance.updateContact(contact);
                    if (result>0) {
                     
                      setState(() {
                         Navigator.pop(context,'done');
                      });
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
                      'Update Contact',
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
              )),
        ],
      ),
    );
  }
}
