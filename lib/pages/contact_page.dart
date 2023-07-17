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
  bool _userEdit = false;
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: _editContact.img != null ? FileImage(File(_editContact.img)):
                      AssetImage('images/person.png')
                  ),
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Nome'),
              onChanged: (text){
                _userEdit = true;
                setState(() {
                  _editContact.name = text;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
