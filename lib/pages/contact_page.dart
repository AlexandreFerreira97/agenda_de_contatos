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
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _focusName = FocusNode();

  bool _userEdit = false;
  Contact? _editContact;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.contact == null) {
      _editContact = Contact();
    } else {
      _editContact = Contact.fromMap(widget.contact.toMap());

      _nameController.text = _editContact.name;
      _emailController.text = _editContact.email;
      _phoneController.text = _editContact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text(_editContact.name ?? 'Novo Contato'),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_editContact.name != null && _editContact.name.isNotEmpty) {
                Navigator.pop(context, _editContact);
              } else {
                FocusScope.of(context).requestFocus(_focusName);
              }
            },
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
                          image: _editContact.img != null
                              ? FileImage(File(_editContact.img))
                              : AssetImage('images/person.png')),
                    ),
                  ),
                ),
                TextField(
                  controller: _nameController,
                  focusNode: _focusName,
                  decoration: InputDecoration(labelText: 'Nome'),
                  onChanged: (text) {
                    _userEdit = true;
                    setState(() {
                      _editContact.name = text;
                    });
                  },
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  onChanged: (text) {
                    _userEdit = true;
                    _editContact.email = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'phone'),
                  onChanged: (text) {
                    _userEdit = true;
                    _editContact.phone = text;
                  },
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
        ));
}

