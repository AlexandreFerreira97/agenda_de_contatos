import 'dart:js';

import 'package:agenda_de_contatos/helpers/contact_helper.dart';
import 'package:agenda_de_contatos/pages/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:agenda_de_contatos/helpers/contact_helper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  ContactHelper  helper = ContactHelper();
  List<Contact> contacts = [];

  @override
  void initState(){
    super.initState();

   _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:
        Text('Contatos'),
          backgroundColor: Colors.red,
          centerTitle: true,
        ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
      onPressed: _showContactPage(),
      backgroundColor:Colors.red,
      child: Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: contatcs.length,
        itemBuilder: (context, index){
          return _contactCard(context, index);
        }
      ),
    );
  }

  Widget _contactCard(BuildContext context, int index){
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: contacts[index].img != null ? FileImage(File(contacts[index].img)):
                        AssetImage('images/person.png')
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(contacts[index].name ?? '',
                    style: TextStyle(fontSize: 22.0,
                    fontWeight: FontWeight.bold),),
                  Text(contacts[index].email ?? '',
                    style: TextStyle(fontSize: 18.0,),
                  ),
                  Text(contacts[index].phone ?? '',
                    style: TextStyle(fontSize: 18.0,),),
                  ],
              ),
            ],
          )
        ),
      ),
      onTap: (){
          _showContactPage(contact: contacts(index));
      },
    );
  }

  void _showContactPage() async {
    final recContact = await Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context) => ContactPage(contact: contact,))
    );
    if(recContact != null){
      if(recContact != null){
        await helper.updateContact(recContact);
        _getAllContacts();
      }
    }
  }

  void _getAllContacts(){
    helper.getAllContacts().then((list){
      setState(){
        contacts = list;
      });
    });
  }
}
