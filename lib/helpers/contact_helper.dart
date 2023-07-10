import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String contactTable = 'contactTable';
const String idColumn = 'idColumn';
const String nameColumn = 'nameColumn';
const String emailColumn = 'emailColumn';
const String phoneColumn = 'phoneColumn';
const String imgColumn = 'imgColumn';

class ContactHelper{
  static final ContactHelper _instance = ContactHelper.internal();
  factory ContactHelper() => _instance;
  ContactHelper.internal();

  Database _db;

  get db{
    if(_db != null){
      return _db;
    }else{
      _db = initDb();
    }
  }

  initDb() async{
    final databasesPath = await getDataBasesPath();
    final path = join(databasesPath,'contacts.db');

    openDatabase(path, version: 1, onCreate: (Database db, int newVersion) async {
      await db.execute(
        "CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT,$phoneColumn TEXT, $imgColumn TEXT)"
      );
    });
  }
}

class Contact{
  late int id;
  late String name;
  late String email;
  late String phone;
  late String img;

  Contact.fromMap(Map map){
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
  }
  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img
    };
    map[idColumn] = id;
    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Contact(id: $id, name: $name, email: $email, phone: $phone, img: $img)';
  }
}