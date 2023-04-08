import 'package:contacts/contacts.dart';
import 'package:contacts/service/localDb/local_db.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDB().setupDb();
  runApp(const ProviderScope(child: Contacts()));
}
