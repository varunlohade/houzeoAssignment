import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/contact_model.dart';
import 'dart:io' as io;

class LocalDB {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  static Database? _db;

  setupDb() async {
    var pref = await _pref;
    pref.setBool("boarding", true);
    openDatabase(
      join(await getDatabasesPath(), 'contact_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE contact(id String PRIMARY KEY, name TEXT,sirname TEXT,companyname TEXT, phonenumber TEXT, email TEXT)',
        );
      },
      version: 1,
    );
  }

  addContact(Contact contact) async {
    final database =
        openDatabase(join(await getDatabasesPath(), 'contact_database.db'));

    // Get a reference to the database.
    final db = await database;

    await db.insert(
      'contact',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Contact>?> getallContact() async {
    final database =
        openDatabase(join(await getDatabasesPath(), 'contact_database.db'));

    // Get a reference to the database.
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('contact');

    return List.generate(maps.length, (i) {
      return Contact(
          id: maps[i]['id'],
          contactName: maps[i]['name'],
          contactSirName: maps[i]['sirname'],
          companyName: maps[i]['companyname'],
          phoneNumber: maps[i]['phonenumber'],
          emailAddress: maps[i]['email']);
    });
  }

  Future<void> updateContact(Contact contact) async {
    final database =
        openDatabase(join(await getDatabasesPath(), 'contact_database.db'));

    // Get a reference to the database.
    final db = await database;
    await db.update('contact', contact.toMap(),
        where: 'id = ?', whereArgs: [contact.id]);
  }

  Future<void> deleteContact(int id) async {
    final database =
        openDatabase(join(await getDatabasesPath(), 'contact_database.db'));

    // Get a reference to the database.
    final db = await database;
    await db.delete('contact', where: 'id = ?', whereArgs: [id]);
  }

  getApplicationDocumentsDirectory() {}
}
