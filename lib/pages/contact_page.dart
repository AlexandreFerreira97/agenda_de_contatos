import 'package:flutter/material.dart';
import 'package:agenda_de_contatos/helpers/contact_helper.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key, required this.contact}) : super(key: key);

  final Contact contact;

  ContactPage(this.contact);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
