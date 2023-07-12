import 'package:agenda_de_contatos/helpers/contact_helper.dart';
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

    helper.getAllContacts().then((list){
      setState(){
        contacts = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: AppBar(title:
        Text('Contatos'),
          backgroundColor(Colors.red),
          centerTitle: true,
        )
        backgroundColor(Colors.white),
      floatingActionButton: FloatingActionButton(
      onPressed: (){},
      child: Icon(Icons.add),
      backgroundColor(Colors.red),
      ),
      body: ListView.builder(
        padding: EdgeInsetsAll(10.0),
        itemCount: contatcs.length,
        itemBuilder: (context, index){

        }
      ),
    );
  }
}
