import 'dart:js';
import 'package:url_launcher/url_launcher.dart';
import 'package:agenda_de_contatos/helpers/contact_helper.dart';
import 'package:agenda_de_contatos/pages/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:agenda_de_contatos/helpers/contact_helper.dart';

enum OrderOptions{orderaz, orderza}

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
          actions: [
            PopupMenuButton <OrderOptions> (
                itemBuilder:(context) => PopupMenuEntry<OrderOptions>[
                  const PopupMenuItem <OrderOptions>(
                      child: Text('Ordenas de A-Z'),
                      value: OrderOptions.orderaz,
                  ),
                const PopupMenuItem <OrderOptions>(
                  child: Text('Ordenas de Z-A'),
                  value: OrderOptions.orderza,
                ),
                ],
              onSelected: _orderList,
            )
          ],
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
          _showOptions(context, index);
      },
    );
  }

  void _showOptions(BuildContext context, int index){
    showModalBottomSheet(context: context,
        builder: (context){
          return BottomSheet(onClosing: (){},
              builder: (context){
            return Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(onPressed: (){
                    launch('tel: ${contacts[index].phone}');
                    Navigator.pop(context);
                  },
                      child: const Text('Ligar',
                        style: TextStyle(color:Colors.red,
                            fontSize: 20.0) ,)),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                    _showContactPage(contact: contacts[index]);
                  },
                      child: const Text('Editar',
                        style: TextStyle(color:Colors.red,
                            fontSize: 20.0) ,)),
                  TextButton(onPressed: (){
                    helper.deleteContact(contacts[index].id);
                    setState(() {
                      contacts.removeAt(index);
                      Navigator.pop(context);
                    });
                  },
                      child: const Text('Excluir',
                        style: TextStyle(color:Colors.red,
                            fontSize: 20.0) ,)),
                ],
              ),
            );
          });
        });
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

  void _orderList(OrderOptions result){
    switch(result){
      case OrderOptions.orderaz:
        contacts.sort((a,b){
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        break;
      case OrderOptions.orderza:
        contacts.sort((a,b){
          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
        });
        break;
    }
    setState((){
        });
  }
}
