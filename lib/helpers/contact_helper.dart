import 'package:flutter/material.dart';

class ContactHelper{
}

class Contact{
  late int id;
  late String name;
  late String email;
  late String phone;
  late String img;

  Contact.fromMap(Map map);
}