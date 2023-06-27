import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqf_lite/dialog.dart';

import 'Person.dart';
import 'PersonDB.dart';

class HomeController extends GetxController {
  late final PersonDB crudStorage;
  @override
  void onInit() {
    crudStorage = PersonDB(dbName: 'db.sqlite');
    crudStorage.open();
    super.onInit();
  }

  @override
  void onClose() {
    crudStorage.close();
    super.onClose();
  }

  Future<void> addToList(String firstName, String lastName) async {
    print(first_name.text);
    print(last_name.text);
    first_name.clear();
    last_name.clear();
    await crudStorage.create(firstName, lastName);
  }

  // ignore: non_constant_identifier_names
  TextEditingController first_name = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController last_name = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController update_first_name = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController update_last_name = TextEditingController();

  Future<bool> showDeleteDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return deleteDialog(context);
      },
    ).then((value) {
      if (value is bool) {
        return value;
      } else {
        return false;
      }
    });
  }

  Future<bool> showUpdateDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return updateDialog(context);
      },
    ).then((value) {
      if (value is bool) {
        return value;
      } else {
        return false;
      }
    });
  }

  Future handleUpdate(BuildContext context, Person person) async {
    update_first_name.text = person.firstName;
    update_last_name.text = person.lastName;
    bool shouldUpdate = await showUpdateDialog(context);

    final updatedPerson = Person(
      id: person.id,
      firstName: update_first_name.text,
      lastName: update_last_name.text,
    );
    if (shouldUpdate) {
      crudStorage.update(updatedPerson);
    }
  }

  Future handleDelete(BuildContext context, Person person) async {
    bool shouldDelete = await showDeleteDialog(context);
    if (shouldDelete) {
      crudStorage.delete(person);
    }
  }
}
