import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqf_lite/controller.dart';

Widget deleteDialog(BuildContext context) {
  return AlertDialog(
    content: const Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        "Are you sure you want to delete this item?",
        style: TextStyle(fontSize: 15),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop(true);
        },
        child: Text(
          'Delete',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop(false);
        },
        child: Text(
          'No',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      )
    ],
  );
}

Widget updateDialog(BuildContext context) {
  var controller = Get.find<HomeController>();
  return AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            "Enter the values you want to update:",
            style: TextStyle(fontSize: 15),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller.update_first_name,
            decoration: const InputDecoration(
              hintText: 'Enter first name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller.update_last_name,
            decoration: const InputDecoration(
              hintText: 'Enter last name',
            ),
          ),
        ),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop(false);
        },
        child: Text(
          'Cancel',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop(true);
        },
        child: Text(
          'Save',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      )
    ],
  );
}
