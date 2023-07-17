import 'package:flutter/material.dart';
import 'package:agenda_de_contatos/helpers/contact_helper.dart';

class ContactPage extends StatefulWidget {
  //const ContactPage({Key? key, required this.contact}) : super(key: key);

  final Contact contact;

  ContactPage(this.contact);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  Contact? _editContact;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.contact == null){
      _editContact = Contact();
    }else{
      _editContact = Contact.fromMap(widget.contact.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(_editContact.name ?? 'Novo Contato'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.red,
        child: const Icon(Icons.save),
      ),
    );
  }
}
