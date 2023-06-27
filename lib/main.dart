import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Operations'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}

class Person implements Comparable {
  final int id;
  final String firstName;
  final String lastName;

  Person({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  @override
  int compareTo(covariant Person other) => id.compareTo(other.id);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Person && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Person, id = $id, firstName: $firstName, lastName: $lastName';
  }
}

class PersonDB {
  final String dbName;
  Database? _db;
  PersonDB(this.dbName);
  List<Person> _persons = [];
  final _streamController = StreamController<List<Person>>.broadcast();
  Future<List<Person>> _fetchPeople() async {}

  Future<bool> open() async {
    if (_db != null) {
      return true;
    }
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/$dbName';
    try {
      final db = await openDatabase(path);
      _db = db;

      //Create Table
      const create = '''CREATE TABLE IF NOT EXISTS PEOPLE(
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        FIRST_NAME STRING NOT NULL,
        LAST_NAME STRING NOT NULL
      )''';
      await db.execute(create);
      //Read all existing Person objects from the db
      _persons = await _fetchPeople();
      _streamController.add(_persons);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
